import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:todo_client/src/repository/repository.dart';

import '../source/hive_config.dart';

class AuthenticationStorage {
  const AuthenticationStorage();
  HiveConfig get _config => HiveConfig();

  Box<String> get _myBox => _config.tokenBox;
  static const accessTokenKey = "#ACCESS_TOKEN";
  static const refreshTokenKey = "#REFRESH_TOKEN";
  static const userInfoKey = "#APP_USER_KEY";

  saveUserToken(String accessToken, String refreshToken) async {
    await _myBox.put(accessTokenKey, accessToken);
    await _myBox.put(refreshTokenKey, refreshToken);
  }

  ({String accessToken, String refreshToken})? getUserToken() {
    final access = _myBox.get(accessTokenKey);
    final refresh = _myBox.get(refreshTokenKey);

    if (access != null && refresh != null) {
      return (accessToken: access, refreshToken: refresh);
    }
    return null;
  }

  saveAppUser(AppUser newUser) async {
    await _myBox.put(userInfoKey, jsonEncode(newUser.toJson()));
  }

  AppUser? getCurrentUser() {
    final currentUser = _myBox.get(userInfoKey);
    if (currentUser != null) return AppUser.fromJson(jsonDecode(currentUser));
    return null;
  }

  clearTokens() async {
    await _myBox.delete(accessTokenKey);
    await _myBox.delete(refreshTokenKey);
  }

  delete() async {
    _myBox.clear();
  }
}
