import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  final String _localKey = 'locale';

  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  Future<void> loadInitialLanguage() async {
    Locale locale = await _getLocale();
    _currentLocale = locale;

    notifyListeners();
  }

  void changeLocal(Locale newLocale) {
    if (_currentLocale == newLocale) return;

    _currentLocale = newLocale;
    _saveLocal(_currentLocale.languageCode);
    notifyListeners();
  }

  Future<void> _saveLocal(String locale) async {
    SharedPreferences pfrs = await SharedPreferences.getInstance();
    await pfrs.setString(_localKey, locale);
  }

  Future<Locale> _getLocale() async {
    SharedPreferences pfrs = await SharedPreferences.getInstance();
    String savedLocale = pfrs.getString(_localKey) ?? 'en';
    return Locale(savedLocale);
  }
}
