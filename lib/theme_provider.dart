import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeModeType _currentThemeMode = ThemeModeType.light;
  SharedPreferences _prefs;

  ThemeProvider(this._prefs) {
    _loadThemeMode();
  }

  ThemeModeType get currentThemeMode => _currentThemeMode;

  void toggleThemeMode() {
    _currentThemeMode = _currentThemeMode == ThemeModeType.light
        ? ThemeModeType.dark
        : ThemeModeType.light;
    _saveThemeMode();
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final isDarkTheme = _prefs.getBool('isDarkTheme') ?? false;
    _currentThemeMode = isDarkTheme ? ThemeModeType.dark : ThemeModeType.light;
    notifyListeners();
  }

  Future<void> _saveThemeMode() async {
    await _prefs.setBool(
      'isDarkTheme',
      _currentThemeMode == ThemeModeType.dark,
    );
  }
}
