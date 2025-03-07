import 'package:shared_preferences/shared_preferences.dart';

const String kToken = 'token';
const String kRefreshToken = 'refreshToken';
const String kAccessToken = 'accessToken';
const String kUserID = 'userID';

class TaskPreferences {
  final SharedPreferences _preferences;
  TaskPreferences(this._preferences);

  Future<bool> saveToken(String token) async {
    return await _preferences.setString(kToken, token);
  }

  Future<bool> deleteToken() async {
    return await _preferences.remove(kToken);
  }

  String? getToken() {
    return _preferences.getString(kToken);
  }

  Future<bool> saveRefreshToken(String token) async {
    return await _preferences.setString(kRefreshToken, token);
  }

  Future<bool> deleteRefreshToken() async {
    return await _preferences.remove(kRefreshToken);
  }

  String? getRefreshToken() {
    return _preferences.getString(kRefreshToken);
  }

   Future<bool> saveUserId(String token) async {
    return await _preferences.setString(kUserID, token);
  }

  Future<bool> deleteUserId() async {
    return await _preferences.remove(kUserID);
  }

  String? getUserId() {
    return _preferences.getString(kUserID);
  }

}
