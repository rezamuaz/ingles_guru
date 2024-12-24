import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/model/user_data.dart';
import 'package:sysbit/src/features/signin_page/data/model/user_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static String pickFirstWord(String sentence) {
    // Trim the sentence to remove leading/trailing spaces
    String trimmedSentence = sentence.trim();

    // Split the sentence by spaces into a list of words
    List<String> words = trimmedSentence.split(' ');

    // Return the first word if it exists, otherwise return null
    if (words.isNotEmpty && words[0].isNotEmpty) {
      return words[0];
    }
    return ""; // Return null if the sentence is empty
  }

  static int countWords(String text) {
    // Trim the input and check if it's empty
    text = text.trim();
    if (text.isEmpty) {
      return 0;
    } else {
      // Split the string by whitespace and filter out empty elements
      return text.split(RegExp(r'\s+')).length;
    }
  }

  static Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Route createRoute(Widget route) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }

  static zoomOutPageRoute(Widget route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  static Future<String> createJwt(UserAuth user) async {
    // Create a JWTsd

    final jwt = JWT(
      {
        "iat": DateTime.now().millisecondsSinceEpoch ~/ 1000,
        "exp": DateTime.now()
                .add(const Duration(minutes: 15))
                .millisecondsSinceEpoch ~/
            1000,
        "sub": user.sub,
        "email": user.email,
        "name": user.name,
        "picture": user.picture,
      },
    );

    // Sign the JWT with RSA SHA-256

    final pemContent = await rootBundle.loadString(Assets.keys.privateKey);
    // Remove PEM header and footer
    final privateKey = pemContent
        .replaceAll(RegExp(r'-----BEGIN (.*?)-----'), '')
        .replaceAll(RegExp(r'-----END (.*?)-----'), '')
        .replaceAll(RegExp(r'\s+'), ''); // Remove whitespaces and newlines
    // Decode the base64 content
    final keyBytes = base64Decode(privateKey);
    final signer = RSAPrivateKey.bytes(keyBytes);
    final token = jwt.sign(signer, algorithm: JWTAlgorithm.RS256);
    return token;
  }

  Future<Map<String, dynamic>> getPlatformInfo() async {
    var deviceData = <String, dynamic>{};

    try {
      if (!kIsWeb) {
        deviceData = switch (defaultTargetPlatform) {
          TargetPlatform.android =>
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
          TargetPlatform.iOS =>
            _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
          TargetPlatform.linux =>
            _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
          TargetPlatform.windows =>
            _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
          TargetPlatform.macOS =>
            _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
          TargetPlatform.fuchsia => <String, dynamic>{
              'Error:': 'Fuchsia platform isn\'t supported'
            },
        };
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'os': "android",
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'os': "iOS",
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'os': "linux",
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'os': "macOS",
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'patchVersion': data.patchVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'os': "windows",
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }

  static Token getToken(EncryptedSharedPreferences encryptedSharedPreferences) {
    var usr = encryptedSharedPreferences.getString(Keys.authKey);
    if (usr != null) {
      return Token.fromJson(jsonDecode(usr));
    } else {
      return Token();
    }
  }

  static UserData getUser(
      EncryptedSharedPreferences encryptedSharedPreferences) {
    var usr = encryptedSharedPreferences.getString(Keys.userKey);
    if (usr != null) {
      return UserData.fromJson(jsonDecode(usr));
    } else {
      return UserData();
    }
  }
}
