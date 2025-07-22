import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  /// Initialize the SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Set a string value
  static Future<bool> setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  /// Get a string value
  static String? getString(String key) {
    return _prefs!.getString(key);
  }

  /// Set a boolean value
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  /// Get a boolean value
  static bool? getBool(String key) {
    return _prefs!.getBool(key);
  }

  /// Set an integer value
  static Future<bool> setInt(String key, int value) async {
    return await _prefs!.setInt(key, value);
  }

  /// Get an integer value
  static int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  /// Remove a specific key
  static Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }

  /// Clear all preferences
  static Future<bool> clear() async {
    return await _prefs!.clear();
  }
}
// ----> usage
// await SharedPrefsHelper.setString('token', 'abc123');
// await SharedPrefsHelper.setBool('isLoggedIn', true);
// String? token = SharedPrefsHelper.getString('token');
// bool? isLoggedIn = SharedPrefsHelper.getBool('isLoggedIn');
// await SharedPrefsHelper.remove('token');
