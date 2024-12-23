import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/local_storage/object_box/quiz_answer_repository.dart';
import 'package:sysbit/src/core/local_storage/object_box/store_repository.dart';
import 'package:sysbit/src/core/local_storage/object_box/word_repository.dart';
import 'package:sysbit/src/core/theme/theme_config.dart';
import 'package:sysbit/src/features/conversation_page/presentation/cubit/lesson_data_cubit.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';
import 'package:sysbit/src/features/splash_page/presentation/pages/splash_page.dart';
import 'package:sysbit/src/localization/app_localizations.dart';

import 'features/root_page/presentation/cubit/navbar_view_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var logger = Logger(
  printer: PrettyPrinter(),
);

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({super.key, required StoreRepository storeRepository})
      : _storeRepository = storeRepository;

  final StoreRepository _storeRepository;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<StoreRepository>.value(
          value: _storeRepository,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<WordRepository>(
            create: (_) => WordRepository(store: _storeRepository.store),
          ),
          RepositoryProvider<QuizAnswerRepository>(
            create: (_) => QuizAnswerRepository(store: _storeRepository.store),
          ),
          RepositoryProvider<ProgressRepository>(
            create: (_) => ProgressRepository(store: _storeRepository.store),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => LessonDataCubit(),
            ),
            BlocProvider(
              create: (context) => NavbarViewCubit(),
            )
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,

            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            locale: const Locale('id', "ID"),
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales // English, no country code
            ,

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) => S.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            themeMode: ThemeMode.light,
            theme: UXTheme.lightTheme
              ..copyWith(
                extensions: <ThemeExtension<dynamic>>[
                  // CustomColors.light,
                ],
              ),
            darkTheme: UXTheme.darkTheme,

            // initialRoute: "/",
            // onGenerateRoute: RouteGenerator.generateRoute,

            home: const SplashPage(),
            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
          ),
        ),
      ),
    );
  }
}
