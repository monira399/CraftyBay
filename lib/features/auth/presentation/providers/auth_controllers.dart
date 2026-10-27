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
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    accessToken = sharedPreferences.getString(_tokenKey);

    final String? userData =
    sharedPreferences.getString(_userKey);

    if (accessToken != null &&
        accessToken!.isNotEmpty &&
        userData != null) {
      userModel = UserModel.fromJson(
        jsonDecode(userData),
      );
    }
  }

  static Future<bool> isAlreadyLoggedIn() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    final String? token = sharedPreferences.getString(_tokenKey);

    return token != null && token.isNotEmpty;
  }

  static Future<void> clearUserData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.clear();

    accessToken = null;
    userModel = null;
  }
}