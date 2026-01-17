import 'package:flutter/material.dart';
import '../utils/language_helper.dart';

class LocalizationProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Locale get locale => _locale;

  // Language mappings
  static const Map<String, String> languageMap = {
    'हिंदी': 'hi',
    'English': 'en',
    'ਪੰਜਾਬੀ': 'pa',
    'ગુજરાતી': 'gu',
    'मराठी': 'mr',
  };

  static const Map<String, String> reverseLanguageMap = {
    'hi': 'हिंदी',
    'en': 'English',
    'pa': 'ਪੰਜਾਬੀ',
    'gu': 'ગુજરાતી',
    'mr': 'मराठी',
  };

  // Initialize locale from saved preference
  Future<void> initializeLocale() async {
    final savedLanguageCode = await LanguageHelper.getSavedLanguage();
    if (savedLanguageCode != null && languageMap.containsValue(savedLanguageCode)) {
      _locale = Locale(savedLanguageCode);
      notifyListeners();
    }
  }

  // Change language by display name (e.g., 'हिंदी')
  Future<void> changeLanguageByName(String languageName) async {
    final languageCode = languageMap[languageName];
    if (languageCode != null) {
      await changeLanguage(languageCode);
    }
  }

  // Change language by code (e.g., 'hi')
  Future<void> changeLanguage(String languageCode) async {
    if (languageMap.containsValue(languageCode)) {
      _locale = Locale(languageCode);
      await LanguageHelper.saveLanguage(languageCode);
      notifyListeners();
    }
  }

  // Get current language display name
  String getCurrentLanguageName() {
    return reverseLanguageMap[_locale.languageCode] ?? 'English';
  }

  // Get all supported languages
  List<String> getSupportedLanguages() {
    return languageMap.keys.toList();
  }

  // Check if a language is supported
  bool isLanguageSupported(String languageCode) {
    return languageMap.containsValue(languageCode);
  }
}