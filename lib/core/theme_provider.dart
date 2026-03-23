/*
 * File: theme_provider.dart
 * Description: ChangeNotifier that manages the app's dark/light theme
 *              and font size factor, persisting both via SharedPreferences.
 *
 * Dependencies:
 * - SharedPreferences
 *
 * Lifecycle:
 * - Instantiated once in main.dart via MultiProvider
 * - Lives for the entire app session
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app's active theme mode and font size scaling.
///
/// Fields:
/// - _isDarkMode: whether dark mode is currently active
/// - _fontSizeFactor: the current font size scaling factor (0.8–1.0)
///
/// Usage:
/// - Provided globally via [MultiProvider] in main.dart
/// - Consumed by [SettingsScreen] for the dark mode toggle and text-size slider
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  double _fontSizeFactor = 1.0;

  /// Whether dark mode is currently active.
  bool get isDarkMode => _isDarkMode;

  /// The current font size scaling factor, clamped between 0.8 and 1.0.
  double get fontSizeFactor => _fontSizeFactor;

  /// Creates a [ThemeProvider] and loads persisted preferences.
  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _fontSizeFactor = prefs.getDouble('fontSizeFactor') ?? 1.0;
    notifyListeners();
  }

  /// Toggles between dark and light theme and persists the change.
  ///
  /// Side effects:
  /// - Updates [_isDarkMode]
  /// - Writes [isDarkMode] to SharedPreferences
  /// - Notifies all listeners
  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  /// Sets the font size scaling factor and persists the change.
  ///
  /// The [factor] is clamped to the range `[0.8, 1.0]`.
  ///
  /// Side effects:
  /// - Updates [_fontSizeFactor]
  /// - Writes [fontSizeFactor] to SharedPreferences
  /// - Notifies all listeners
  Future<void> setFontSizeFactor(double factor) async {
    _fontSizeFactor = factor.clamp(0.8, 1.0);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSizeFactor', _fontSizeFactor);
  }

  /// Returns [ThemeMode.dark] when dark mode is active,
  /// otherwise returns [ThemeMode.light].
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
