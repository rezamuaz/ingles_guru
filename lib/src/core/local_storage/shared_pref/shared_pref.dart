import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/model/user_data.dart';

class SharedPrefs {
  static late final EncryptedSharedPreferences instance;
  static Future<EncryptedSharedPreferences> init() async =>
      instance = EncryptedSharedPreferences.getInstance();

  /// Set [Token] for user
 static Future<void> setToken(Token token)async{
   await instance.setString(Keys.authKey, jsonEncode(token.toJson()));
  } 
   /// Get [Token] for user
 static Future<Token?> getToken()async{
    String? token = instance.getString(Keys.authKey);
    if (token != null){
          return Token.fromJson(jsonDecode(token));
    }else{
      return null;
    } 
  }
  /// remove [Token] from disk
 static  Future<void> removeToken()async{
    await instance.remove(Keys.authKey);
  }

    /// Set [UserData] for user
 static Future<void> setUser(UserData user)async{
   await instance.setString(Keys.userKey, jsonEncode(user.toJson()));
  } 
   /// Get [UserData] for user
 static Future<UserData?> getUser()async{
    String? token = instance.getString(Keys.userKey);
    if (token != null){
          return UserData.fromJson(jsonDecode(token));
    }else{
      return null;
    } 
  }
   /// remove [UserData] from disk
 static  Future<void> removeUser()async{
    await instance.remove(Keys.userKey);
  }
}
