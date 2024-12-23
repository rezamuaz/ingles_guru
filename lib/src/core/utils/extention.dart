import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';

extension Currency on num {
  String get toCurrency => NumberFormat.currency(
        locale: 'id_ID',
        decimalDigits: 0,
        symbol: 'Rp.',
      ).format(this);
}


extension StringHashing on String {
  String generateHashedFileName() {
    // Generate a hash of the original filename
    var bytes = utf8.encode(this); // Convert to UTF-8
    var digest = sha256.convert(bytes); // Generate SHA-256 hash

    // Create a new unique filename using the hash
    return digest.toString();
  }
}

extension DateFormatID on DateTime {
  String get formatID => DateFormat("dd MMMM yyyy", "in_ID").format(this);
  String get formatTimeID =>
      DateFormat("HH:mm dd MMMM yyyy", "in_ID").format(this);
}
