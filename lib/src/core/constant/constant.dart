import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
GoogleSignIn googleSignIn =
    GoogleSignIn(signInOption: SignInOption.standard, scopes: scopes);
final List<String> scopes = <String>['email', 'profile', 'openid'];

class Constants {
  static const String defaultProfilePhotoUrl = "https://gravatar.com/avatar";
  // Padding
  static const double kPaddingXS = 4.0;
  static const double kPaddingS = 8.0;
  static const double kPaddingM = 16.0;
  static const double kPaddingL = 18.0;
  static const double kPaddingXL = 32.0;

  // Font Size
  static const double kFontSizeXS = 6.0;
  static const double kFontSizeS = 12.0;
  static const double kFontSizeM = 14.0;
  static const double kFontSizeL = 16.0;
  static const double kFontSizeXL = 18.0;
  static const double kFontSizeXXL = 20.0;
  static const double kFontSizeX = 24.0;
  static const double kFontSizeXX = 32.0;

  // Radius
  static const double kRadiusS = 4.0;
  static const double kRadiusM = 8.0;
  static const double kRadiusL = 16.0;
  static const double kRadiusXL = 32.0;

  // Animation
  static const Duration kPageAnimationDuration = Duration(milliseconds: 375);
  static const Duration kButtonAnimationDuration = Duration(milliseconds: 600);
  static const Duration kCardAnimationDuration = Duration(milliseconds: 400);
  static const Duration kRippleAnimationDuration = Duration(milliseconds: 400);

  //Icons Size
  static const double kIconsXS = 40.0;
  static const double kIconsS = 16.0;
  static const double kIconsM = 24.0;
  static const double kIconsL = 32.0;
  static const double kIconsXL = 48.0;
}