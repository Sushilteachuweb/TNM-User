import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
  static Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("languageCode", code);
  }

  static Future<String?> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("languageCode");
  }
}
