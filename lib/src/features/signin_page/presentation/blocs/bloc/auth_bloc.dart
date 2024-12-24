import 'dart:io';

import 'package:apple_sign_in_plugin/apple_sign_in_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/model/user_data.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/signin_page/data/model/register_req.dart';
import 'package:sysbit/src/features/signin_page/data/model/user_auth.dart';
import 'package:sysbit/src/features/signin_page/domain/repository/signin_repo_impl.dart';
import 'package:sysbit/src/features/splash_page/data/model/device_info.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        signing: (user) async {
          emit(const AuthState.loading());
          //Get Device Info
          Map<String, dynamic> deviceInfo = await Utils().getPlatformInfo();
          String? fcmToken = "";
          fcmToken = await messaging.getToken();
          var idToken = await Utils.createJwt(user);
          var regis = RegisterReqMod(
              appId: user.sub,
              idToken: idToken,
              os: deviceInfo["os"],
              language: "id",
              deviceInfo: deviceInfo,
              fcmToken: fcmToken);
          // Await the registration response
          final regisResult = await SigninRepoImpl().register(regis);
          await regisResult.when(
            success: (data) async {
              var userdata = UserData(
                  email: user.email ?? "",
                  userid: data.id ?? "",
                  appId: user.sub ?? "",
                  displayName: user.name ?? "",
                  photoUrl: user.picture ?? "");
              await SharedPrefs.setUser(userdata);

              Token token = Token(
                  isPremium: data.role!.contains("premium"),
                  accessToken: data.accessToken ?? "",
                  refreshToken: data.refreshToken ?? "",
                  accessExpiredAt: data.accessExpired ?? 0,
                  refreshExpiredAt: data.refreshExpired ?? 0,
                  role: data.role ?? []);
              await SharedPrefs.setToken(token);
              // Update the user with the new token
              emit(const AuthState.isAuthorized());
            },
            failure: (error) {
              emit(AuthState.isError(error));
            },
          );
        },
        signout: () async {
          emit(const AuthState.loading());
          if (Platform.isAndroid) {
            googleSignIn.disconnect();
          }
          if (Platform.isIOS) {
            await AppleSignInPlugin.signOut();
          }

          SharedPrefs.removeToken();
          SharedPrefs.removeUser();
          return emit(const AuthState.unAuthorized());
        },
        checking: () async {
          emit(const AuthState.loading());
          var token = await SharedPrefs.getToken();
          if (token != null && token.refreshToken.isNotEmpty) {
            final hasConnected = await Network.connection.hasInternetAccess;
            if (hasConnected) {
              //Renew Access Token When Open App
              final renewAccessToken =
                  await SigninRepoImpl().retrivedToken(token.refreshToken);
              return renewAccessToken.when(
                success: (result) async {
                  var newData = token.copyWith(
                      accessToken: result.accessToken ?? "",
                      accessExpiredAt: result.accessExpired ?? 0,
                      isPremium: token.role.contains("premium"),
                      role: token.role);
                  SharedPrefs.setToken(newData);
                  return emit(const AuthState.isAuthorized());
                },
                failure: (error) {
                  return error.maybeWhen(
                    orElse: () {
                        SharedPrefs.removeToken();
                      SharedPrefs.removeUser();
                     return emit(AuthState.isError(error));
                    },
                    unauthorisedRequest: (reason) {
                      if (Platform.isAndroid) {
                        googleSignIn.disconnect();
                      }
                      if (Platform.isIOS) {
                        AppleSignInPlugin.signOut();
                      }

                      SharedPrefs.removeToken();
                      SharedPrefs.removeUser();
                      return emit(const AuthState.unAuthorized());
                    },
                  );
                },
              );
            }

            return emit(const AuthState.isAuthorized());
          }
          if (Platform.isAndroid) {
            googleSignIn.disconnect();
          }
          if (Platform.isIOS) {
            AppleSignInPlugin.signOut();
          }
          SharedPrefs.removeToken();
          SharedPrefs.removeUser();
          return emit(const AuthState.unAuthorized());
        },
      );
    });
  }
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    logger.d(change);
  }

  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    logger.d(event);
  }
}
