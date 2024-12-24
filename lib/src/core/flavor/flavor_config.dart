import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor {
  // ignore: constant_identifier_names
  dev,
  // ignore: constant_identifier_names
  prod,
}

class FlavorConfig {
  static late Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'prod';
      case Flavor.dev:
      default:
        return 'dev';
    }
  }

  //get my enviroment
  static bool get isProd => appFlavor == Flavor.prod;
  static bool get isDev => appFlavor == Flavor.dev;
  // get base url
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.prod:
        return dotenv.get('PROD_BASE_URL', fallback: 'DEV_BASE_URL');
      case Flavor.dev:
      default:
        return dotenv.get('DEV_BASE_URL', fallback: 'DEV_BASE_URL');
    }
  }

  // Future<String> loadStringAsset({required Flavor flavorName}) async {
  //   switch (flavorName) {
  //     case Flavor.APICAL:
  //       return Assets.apps.apical.path;
  //     case Flavor.OTO:
  //       return Assets.apps.oto.path;
  //     case Flavor.EVENT:
  //       return Assets.apps.event.path;
  //     case Flavor.REGAL:
  //       return Assets.apps.regal.path;
  //     case Flavor.YOKE:
  //       return Assets.apps.yoke.path;
  //     case Flavor.KIMBO:
  //       return Assets.apps.kimbo.path;
  //     case Flavor.INDOFOOD:
  //       return Assets.apps.indofood.path;
  //     case Flavor.DEV:
  //     default:
  //       return Assets.apps.dev.path;
  //   }
  // }
}