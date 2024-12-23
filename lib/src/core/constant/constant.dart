import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
GoogleSignIn googleSignIn =
    GoogleSignIn(signInOption: SignInOption.standard, scopes: scopes);
final List<String> scopes = <String>['email', 'profile', 'openid'];
