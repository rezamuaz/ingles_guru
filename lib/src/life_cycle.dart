import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/root_page/presentation/pages/root_page.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({super.key, required this.child});
  final Widget child;
  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    try {
      switch (state) {
        case AppLifecycleState.paused:
          debugPrint("App paused");
          break;
        case AppLifecycleState.resumed:
          debugPrint("App resumed");
          final hasConnected = await Network.connection.hasInternetAccess;
          //  When Internet Connection Enable
          if (hasConnected) {
            await regenerateAccessToken(); // Call an async function
          }

          break;
        case AppLifecycleState.detached:
          debugPrint("App detached");
          break;
        case AppLifecycleState.inactive:
          debugPrint("App inactive");
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<void> regenerateAccessToken() async {
    // try {
    // should create new dio instance because the request interceptor is being locked

    // get refresh token from local storage
    var user = await SharedPrefs.getToken();
    if (user != null) {
      final String refreshToken = user.refreshToken;
      // make request to server to get the new access token from server using refresh token

      final response = await dio.get(
        "${Env.baseUrl}${Env.userStatusEp}",
        options: Options(
            contentType: "application/json",
            headers: {"Authorization": "Bearer $refreshToken"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        bool status =
            response.data['result']; // parse data based on your JSON structure
        if (!status) {
          //Get Access Token
          try {
            final response = await dio.put(
              "${Env.baseUrl}${Env.refreshEp}",
              options: Options(
                contentType: "application/json",
              ),
              data: {
                "refresh_token": refreshToken,
              },
            );
            if (response.statusCode == 200 || response.statusCode == 201) {
              final TokenResp result =
                  TokenResp.fromJson(response.data['result']);
              var newUser = user.copyWith(
                  accessToken: result.accessToken ?? "",
                  role: result.role ?? [],
                  isPremium: true,
                  accessExpiredAt: result.accessExpired ?? 0);
              await SharedPrefs.setToken(newUser);
              try {
                await dio.patch(
                  "${Env.baseUrl}${Env.userStatusEp}",
                  options: Options(
                    contentType: "application/json",
                    headers: {"Authorization": "Bearer $refreshToken"},
                  ),
                  data: {
                    "status": true,
                  },
                );
              } catch (e) {
                logger.e(e);
              }
            } // save to local storage
          } catch (e) {
            logger.e(e);
          }
        }
      } else {}
    }
  }
}
