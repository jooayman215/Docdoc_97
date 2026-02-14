import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future saveToken(String token) async {
    await _prefs?.setString('token', token);
  }

  static String? getToken() {
    return _prefs?.getString('token');
  }

  static Future clearToken() async {
    await _prefs?.remove('token');
  }

  static Future saveUserName(String userName) async {
    await _prefs?.setString('username', userName.trim());
  }

  static String? getUserName() {
    return _prefs?.getString('username');
  }

  static Future logout() async {
    await _prefs?.remove('token');
    await _prefs?.remove('username');
  }
}