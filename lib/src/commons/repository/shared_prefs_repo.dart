import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/core/type_def.dart';
import 'package:music_player/src/models/user_model.dart';
import 'package:music_player/src/res/strings.dart';
import 'package:music_player/src/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsRepoProvider =
    Provider<SharedPrefsRepo>((ref) => SharedPrefsRepo());

class SharedPrefsRepo {
  final String _tokenKey = "COOKIE_TOKEN";
  final String _currentUserKey = "CURRENT_USER";

  Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString(_tokenKey);
    if (AppConfig.devMode) {
      log("Reading cookie", name: LogLabel.sharedPrefs);
      log("Data : $cookie", name: LogLabel.sharedPrefs);
    }
    return cookie;
  }

  Future<User?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_currentUserKey);
    if (AppConfig.devMode) {
      log("Reading user", name: LogLabel.sharedPrefs);
      log("Data : $data", name: LogLabel.sharedPrefs);
    }
    final user = data != null ? User.fromMap(jsonDecode(data)) : null;
    return user;
  }

  Future<String?> getData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString(key);
    if (AppConfig.devMode) {
      log("Reading cookie", name: LogLabel.sharedPrefs);
      log("Data : $cookie", name: LogLabel.sharedPrefs);
    }
    return cookie;
  }

  FutureVoid setCurrentUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (AppConfig.devMode) {
      log("Saving user", name: LogLabel.sharedPrefs);
      log("Data : ${user.toMap()}", name: LogLabel.sharedPrefs);
    }
    prefs.setString(_currentUserKey, jsonEncode(user.toMap()));
  }

  FutureVoid setCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (AppConfig.devMode) {
      log("Saving cookie", name: LogLabel.sharedPrefs);
      log("Data : $cookie", name: LogLabel.sharedPrefs);
    }
    prefs.setString(_tokenKey, cookie);
  }

  FutureVoid clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setData(String key, String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (AppConfig.devMode) {
      log("Saving data", name: LogLabel.sharedPrefs);
      log("Data : $key", name: LogLabel.sharedPrefs);
    }
    prefs.setString(key, cookie);
  }
}
