import 'dart:convert';

import 'package:craftybay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const _tokenKey = 'access_token';
  static const _userKey = 'user_data';

  static UserModel? userModel;
  static String? accessToken;

  static Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;

  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_tokenKey);
    if(accessToken != null) {
      final String? userData = sharedPreferences.getString(_userKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));

    }
  }
   static Future<bool> isAlreadyLoggedIn() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     return await sharedPreferences.getString(_tokenKey) != null;
   }

   Future<void> clearUserData() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.clear();
   }
}