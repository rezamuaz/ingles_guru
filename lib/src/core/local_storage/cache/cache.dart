import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:sysbit/src/app.dart';

class UnicornCache {
  static Future<File?> getFilesCacheManager({
    required String url,
  }) async {
    FileInfo? cache = await DefaultCacheManager().getFileFromCache(url);
    try {
      //File exist in cache

      //Return file when exist
      if (cache!.file.existsSync()) {
        return cache.file;
        // Download nonexist file
      } else {
        try {
          return await DefaultCacheManager().getSingleFile(url);
        } catch (e) {
          logger.e(e);
          return Future.error(e); // Return null if there was an error
        }
      }
      //File nonexist in cache
    } catch (e) {
      logger.e(e);
      throw Exception("Error accessing file: $e");
    }
  }
}
