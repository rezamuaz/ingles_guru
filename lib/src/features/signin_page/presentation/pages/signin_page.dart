import 'dart:io';

import 'package:apple_sign_in_plugin/apple_sign_in_plugin.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:objectbox/objectbox.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/error_response_message.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/dialog/flash_message_wrapper.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/root_page/presentation/pages/root_page.dart';
import 'package:sysbit/src/features/signin_page/data/model/user_auth.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';
import 'package:sysbit/src/features/signin_page/presentation/widget/signing_loading.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  ErrorResponseMessage? _error;
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  
  AuthButtonType? buttonType;
  AuthIconType? iconType;
  bool isLoading = false;
  bool darkMode = false;

  ThemeMode get themeMode => darkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await googleSignIn.canAccessScopes(scopes);
      }
      if (mounted) {
        setState(() {
          _currentUser = account;
          _isAuthorized = isAuthorized;
        });
      }

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      // unawaited(future)
    });
    googleSignIn.signInSilently();
  }

  var materialBanner = const MaterialBanner(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,

    content: AwesomeSnackbarContent(
      messageTextStyle: TextStyle(fontSize: 14, color: Colors.white),
      color: Colors.blue,
      title: 'Internet disconnect',
      message: 'You need connect to internet for login!',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.warning,
      // to configure for material banner
      inMaterialBanner: true,
    ),
    actions: [SizedBox.shrink()],
  );

   void _onRequestError(NetworkExceptions e) {
 
    e.maybeWhen(
      orElse: () => FlashMessage.error(context: context, error: e),
      unprocessableEntity: (m) => _error = m,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          isError: (error) => _onRequestError(error),
          isAuthorized: () {
            if (context.mounted) {
              hideProgressDialogue(context);
              Navigator.of(context)
                  .pushReplacement(Utils.createRoute(const RootPage()));
            }

          },

        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        // appBar: AppBar(
        //     automaticallyImplyLeading: false,
        //     systemOverlayStyle:
        //         const SystemUiOverlayStyle(statusBarColor: Colors.transparent)),

        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: MediaQuery.of(context).size.height * 0.15,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 100, left: 20, right: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.40,
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: SvgPicture.asset(
                                        fit: BoxFit.fitHeight,
                                        Assets.svgs.logo),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: MediaQuery.of(context).size.height * 0.1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Selamat Datang di",
                                            style: GoogleFonts.inter(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w300,
                                                height: 0.5),
                                          ),
                                          Text(
                                            "Ingles Guru",
                                            style: GoogleFonts.inter(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 1.2),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Cara Menyenangkan untuk Belajar Bahasa Inggris",
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Platform.isIOS
                                        ? Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 250),
                                            child: SignInWithAppleButton(
                                               borderRadius: BorderRadius.circular(40),
                                              onPressed: () async {
                                                bool status = await Network
                                                    .connection
                                                    .hasInternetAccess;
                                                if (!status) {
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentMaterialBanner()
                                                      ..showMaterialBanner(
                                                          materialBanner);
                                                    return;
                                                  }
                                                }
                                                if (context.mounted) {
                                                  showDialogue(context);
                                                  final credential =
                                                      await AppleSignInPlugin
                                                          .signInWithApple();
                                               
                                                  var userData = UserAuth(
                                                      name:
                                                          "${credential?.familyName}${credential?.givenName}",
                                                      email:
                                                          "${credential?.email}",
                                                      sub:
                                                          "${credential?.userIdentifier}",
                                                      picture: "");

                                                  BlocProvider.of<AuthBloc>(
                                                          context)
                                                      .add(AuthEvent.signing(
                                                          userData));
                                                  setState(() {
                                                    isLoading = !isLoading;
                                                  });
                                                  // }
                                                }
                                                // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                                                // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                                              },
                                            ))
                                        : const SizedBox(),
                                    SizedBox(height: 10,),
                                    Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 250),
                                            child: GoogleAuthButton(
                                              onPressed: () async {
                                                bool status = await Network
                                                    .connection
                                                    .hasInternetAccess;
                                                if (!status) {
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentMaterialBanner()
                                                      ..showMaterialBanner(
                                                          materialBanner);
                                                    return;
                                                  }
                                                }
                                                // try{
                                                if (context.mounted) {
                                                  showDialogue(context);
                                                  // await requestPermissionUntilGranted();

                                                  _currentUser =
                                                      await googleSignIn
                                                          .signIn();
                                                  if (_currentUser != null) {
                                                    var userData = UserAuth(
                                                        name: _currentUser
                                                            ?.displayName,
                                                        email:
                                                            _currentUser?.email,
                                                        sub: _currentUser?.id,
                                                        picture: _currentUser
                                                            ?.photoUrl);

                                                    BlocProvider.of<AuthBloc>(
                                                            context)
                                                        .add(AuthEvent.signing(
                                                            userData));
                                                  }

                                                  setState(() {
                                                    isLoading = !isLoading;
                                                  });
                                                }
                                              },
                                              themeMode: themeMode,
                                              isLoading: isLoading,
                                              style: AuthButtonStyle(
                                                borderRadius: 20,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .apply(
                                                        color:
                                                            Colors.grey[700]),
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                              ),
                                            ),
                                          ),
                                       
                                    
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const SigningLoading(),
    );
  }

  void hideProgressDialogue(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Continuously request permission until it's granted
  Future<void> requestPermissionUntilGranted() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Keep checking permission status
    while (true) {
      // Request notification permission
      NotificationSettings settings = await messaging.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // print('User granted permission');
        // Optionally, retrieve FCM token after permission is granted
        // String? token = await messaging.getToken();
        // print('FCM Token: $token');
        break; // Stop asking if granted
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        // Provisional permission granted (on iOS)
        // print('User granted provisional permission');
        break; // Stop asking if granted
      } else {
        // print('User denied permission. Asking again...');
        // Delay before asking again to avoid overwhelming the user
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
}
