import 'dart:async';
import 'dart:convert';
import 'package:apple_sign_in_plugin/apple_sign_in_plugin.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sysbit/src/core/flavor/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/notification/notif_api.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  Flavor? flavor,
}) async {
  // FlavorConfig.appFlavor = flavor;
  await Firebase.initializeApp();
  // Initialize Firebase
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await AppleSignInPlugin.initialize(
    pemKeyPath: 'assets/keys/apple_private_key.pem',
    keyId: '9B98V8J7N8',
    teamId: '8FMB6UPTVR',
    clientId: 'com.inglesguru.sys',
  );
  // Register the background message handler
  // FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  NotifApi.init();
  runApp(await builder());
}
