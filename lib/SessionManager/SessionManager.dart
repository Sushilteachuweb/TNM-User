import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = "isLoggedIn";
  static const String _keyPhone = "phone";

  // ✅ Save login session
  static Future<void> saveLogin(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyPhone, phone);
  }

  // ✅ Check login status
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // ✅ Get phone number
  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPhone);
  }

  // ✅ Logout / Clear session
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
