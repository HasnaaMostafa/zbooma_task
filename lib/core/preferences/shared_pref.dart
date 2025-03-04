import 'package:shared_preferences/shared_preferences.dart';

const String kToken = 'token';

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

}
