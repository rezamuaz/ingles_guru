import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';
import 'package:sysbit/src/features/signin_page/presentation/pages/signin_page.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final dio = Dio();
  // when accessToken is expired & having multiple requests call
  // this variable to lock others request to make sure only trigger call refresh token 01 times
  // to prevent duplicate refresh call
  bool _isRefreshing = false;

  // when having multiple requests call at the same time, you need to store them in a list
  // then loop this list to retry every request later, after call refresh token success
  final _requestsNeedRetry =
      <({RequestOptions options, ErrorInterceptorHandler handler})>[];
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log("Response Status Code: [${response.statusCode}]");

    super.onResponse(response, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove("requiresToken"); //remove the auxiliary header
      return handler.next(options);
    }
    // get tokens from local storage, use Hive
    var user = await SharedPrefs.getToken();
    if (user?.accessToken != null || user?.refreshToken != null) {
      var refreshed = true;
      int now = DateTime.now()
          .toUtc()
          .subtract(const Duration(minutes: 5))
          .millisecondsSinceEpoch;
      //Refresh Token Expire
      if (now >= user!.refreshExpiredAt) {
        _performLogout();
        // create custom dio error
        options.extra["tokenErrorType"] = "refreshTokenHasExpired";
        final error = DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          message: "refresh token expire",
        );
        return handler.reject(error);
        // check if tokens have already expired or not
      } else if (now >= user.accessExpiredAt) {
        // regenerate access token
        refreshed = await regenerateAccessToken(dio);
      }

      if (refreshed) {
        // add access token to the request header
        var newUser = await SharedPrefs.getToken();
        options.headers["Authorization"] = "Bearer ${newUser!.accessToken}";
        return handler.next(options);
      } else {
        // create custom dio error
        options.extra["tokenErrorType"] = "failedToRegenerateAccessToken";
        final error = DioException(
            requestOptions: options, type: DioExceptionType.unknown);
        return handler.reject(error);
      }
    } else {
      _performLogout();
      final error =
          DioException(requestOptions: options, type: DioExceptionType.unknown);
      return handler.reject(error);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    // for some reasons the token can be invalidated before it is expired by the backend.
    // then we should navigate the user back to login page
    if (response != null && response.statusCode == 403) {
      // if hasn't not refreshing yet, let's start it
      if (!_isRefreshing) {
        _isRefreshing = true;
        var user = await SharedPrefs.getToken();
        // add request (requestOptions and handler) to queue and wait to retry later
        _requestsNeedRetry
            .add((options: response.requestOptions, handler: handler));

        // call api refresh token
        final isRefreshSuccess =
            await _customeAccessToken(user!, user.refreshToken);

        if (isRefreshSuccess) {
          // refresh success, loop requests need retry
          for (var requestNeedRetry in _requestsNeedRetry) {
            // don't need set new accessToken to header here, because these retry
            // will go through onRequest callback above (where new accessToken will be set to header)

            // won't use await because this loop will take longer -> maybe throw: Unhandled Exception: Concurrent modification during iteration
            // because method _requestsNeedRetry.add() is called at the same time
            // final response = await dio.fetch(requestNeedRetry.options);
            // requestNeedRetry.handler.resolve(response);

            dio.fetch(requestNeedRetry.options).then((response) {
              requestNeedRetry.handler.resolve(response);
            }).catchError((_) {});
          }

          _requestsNeedRetry.clear();
          _isRefreshing = false;
        } else {
          _requestsNeedRetry.clear();
          // if refresh fail, force logout user here
        }
      } else {
        // if refresh flow is processing, add this request to queue and wait to retry later
        _requestsNeedRetry
            .add((options: response.requestOptions, handler: handler));
      }
    } else {
      // ignore other error is not unauthorized
      return handler.next(err);
    }
  }

  void _performLogout() {
    googleSignIn.disconnect();
    SharedPrefs.removeToken();
    SharedPrefs.removeUser();
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SigninPage(),
        ),
        (route) => false);
  }

  /// return true if it is successfully regenerate the access token
  Future<bool> regenerateAccessToken(Dio dio) async {
    try {
      // get refresh token from local storage
      var user = await SharedPrefs.getToken();

      final String refreshToken = user!.refreshToken;
      // make request to server to get the new access token from server using refresh token
      var response = await getAccessToken(refreshToken);
      //success response
      if (response.statusCode == 200 || response.statusCode == 201) {
        var usr = TokenResp.fromJson(response.data["result"]);
        var newUser = user.copyWith(
            accessToken: usr.accessToken ?? "",
            role: usr.role ?? [],
            accessExpiredAt: usr.accessExpired ?? 0);
        await SharedPrefs.setToken(newUser);
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // it means your refresh token no longer valid now, it may be revoked by the backend
        _performLogout();
        return false;
      } else {
        logger.e(response.statusCode);
        return false;
      }
    } on DioException catch (e) {
      logger.e(e.toString());
      return false;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  // Future<UserHive?> getUser(HiveService pref)async{
  //    return await pref.read<UserHive>(
  //       boxName: Keys.userBox, key: Keys.authKey);
  // }

  Future<Response<dynamic>> getAccessToken(String refreshToken) async {
    return await dio.put(
      "${Env.baseUrl}${Env.refreshEp}",
      options: Options(
        contentType: "application/json",
      ),
      data: {
        "refresh_token": refreshToken,
      },
    );
  }

  Future<bool> _customeAccessToken(Token token, String refreshToken) async {
    try {
      final res = await dio.put(
        "${Env.baseUrl}${Env.refreshEp}",
        options: Options(
          contentType: "application/json",
        ),
        data: {
          "refresh_token": refreshToken,
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var usr = TokenResp.fromJson(res.data["result"]);
        var newUser = token.copyWith(
            accessToken: usr.accessToken ?? "",
            role: usr.role ?? [],
            accessExpiredAt: usr.accessExpired ?? 0);
        await SharedPrefs.setToken(newUser);
        return true;
      } else {
        logger.e("refresh token fail ${res.statusMessage ?? res.toString()}");
        return false;
      }
    } catch (e) {
      logger.e("refresh token fail $e");
      return false;
    }
  }
}
