import 'package:advanced_in_app_review/advanced_in_app_review.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/notification/notif_api.dart';
import 'package:sysbit/src/features/account_page/presentation/pages/account_page.dart';
import 'package:sysbit/src/features/home_page/presentation/pages/home_page.dart';
import 'package:sysbit/src/features/premium_page/presentation/pages/premium_page.dart';
import 'package:sysbit/src/features/progress_page/presentation/pages/progress_page.dart';
import 'package:sysbit/src/features/root_page/presentation/cubit/fcm_cubit.dart';
import 'package:sysbit/src/features/root_page/presentation/cubit/navbar_view_cubit.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';
import 'package:sysbit/src/features/signin_page/presentation/pages/signin_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late PersistentTabController _controller;
  // Create a global key for Scaffold to show the dialog globally
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    // Initialize Firebase Messaging and request notification permissions
    requestPermission();

    // Listen for FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("Received a foreground message: ${message.notification?.title}");
      }
      _handleFCM(message);
      await NotifApi.pushNotification(message);
    });

    // Handle notification when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("App opened from notification: ${message.notification?.title}");
      }
      await NotifApi.pushNotification(message);
    });

    AdvancedInAppReview()
        .setMinDaysBeforeRemind(3)
        .setMinDaysAfterInstall(1)
        .setMinLaunchTimes(2)
        .setMinSecondsBeforeShowDialog(4)
        .monitor();
    super.initState();
  }

  // Request notification permission
  Future<void> requestPermission() async {
    NotificationSettings settings =
        await messaging.requestPermission(announcement: true);

    messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print("Notification permission granted");
    // } else {
    //   print("Notification permission denied");
    // }

    // Keep checking permission status
    while (true) {
      // Request notification permission
      // NotificationSettings settings = await messaging.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // print('User granted permission');
        // Optionally, retrieve FCM token after permission is granted
        String? token = await messaging.getToken();

        FcmCubit().updateFcm(token ?? "");
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

  // Handle the FCM message (either foreground or background)
  void _handleFCM(RemoteMessage message) async {
    // Show a dialog when a notification is received
    if (message.data["status"] == "payment paid") {
      var dio = Dio();
      var user = await SharedPrefs.getToken();
      try {
        final response = await dio.put(
          "${Env.baseUrl}${Env.refreshEp}",
          options: Options(
            contentType: "application/json",
          ),
          data: {
            "refresh_token": user?.refreshToken,
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          final TokenResp result = TokenResp.fromJson(response.data['result']);
          var newUser = user?.copyWith(
              accessToken: result.accessToken ?? "",
              role: result.role ?? [],
              isPremium: true);
          await SharedPrefs.setToken(newUser ?? Token());
          try {
            await dio.patch(
              "${Env.baseUrl}${Env.userStatusEp}",
              options: Options(
                contentType: "application/json",
                headers: {"Authorization": "Bearer ${user?.refreshToken}"},
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

      // _showGlobalDialog(message.notification?.title ?? "New Notification",
      //     message.notification?.body ?? "You have a new message.");
    }
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      // const ProgressPage(),
      // const PremiumPage(),
      const AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          iconSize: 32,
          title: ("Home"),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          inactiveIcon: const Icon(Icons.home_outlined)),
      // PersistentBottomNavBarItem(
      //     icon: const Icon(Icons.bar_chart),
      //     iconSize: 32,
      //     title: ("Progress"),
      //     activeColorPrimary: CupertinoColors.black,
      //     inactiveColorPrimary: CupertinoColors.systemGrey,
      //     inactiveIcon: const Icon(Icons.bar_chart_outlined)),
      // PersistentBottomNavBarItem(
      //     icon: const Icon(Icons.diamond),
      //     iconSize: 32,
      //     title: ("Premium"),
      //     activeColorPrimary: CupertinoColors.black,
      //     inactiveColorPrimary: CupertinoColors.systemGrey,
      //     inactiveIcon: const Icon(Icons.diamond_outlined)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          iconSize: 32,
          title: ("Account"),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          inactiveIcon: const Icon(Icons.person_outlined)),
    ];
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unAuthorized: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SigninPage()));
            },
          );
        },
        child: Builder(builder: (context) {
          return PersistentTabView(
            key: scaffoldMessengerKey,
            context,
            controller: _controller,
            screens: _buildScreens(),
            decoration: const NavBarDecoration(
                border:
                    Border(top: BorderSide(width: 2, color: Colors.black12))),
            items: _navBarsItems(),
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardAppears: true,
            popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
            padding: const EdgeInsets.only(top: 8),
            backgroundColor: Colors.white,
            isVisible: context.watch<NavbarViewCubit>().state,
            animationSettings: const NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                duration: Duration(milliseconds: 200),
                screenTransitionAnimationType:
                    ScreenTransitionAnimationType.fadeIn,
              ),
            ),
            confineToSafeArea: true,
            navBarHeight: kBottomNavigationBarHeight,
            navBarStyle: NavBarStyle
                .style13, // Choose the nav bar style with this property
          );
        }),
      );
}
