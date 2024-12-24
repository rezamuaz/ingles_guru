import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Network {
 static  final connection = InternetConnection.createInstance(
  customCheckOptions: [
    InternetCheckOption(uri: Uri.parse('https://one.one.one.one'),timeout: const Duration(seconds: 60)),
  ],
);
}
