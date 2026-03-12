import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  double _fontSizeFactor = 1.0;

  bool get isDarkMode => _isDarkMode;
  double get fontSizeFactor => _fontSizeFactor;

  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _fontSizeFactor = prefs.getDouble('fontSizeFactor') ?? 1.0;
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  Future<void> setFontSizeFactor(double factor) async {
    _fontSizeFactor = factor.clamp(0.8, 1.0);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSizeFactor', _fontSizeFactor);
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
