/*
 * File: language_provider.dart
 * Description: ChangeNotifier that manages the app's active locale
 *              and holds all localised string/data content for EN and TH.
 *
 * Dependencies:
 * - SharedPreferences (to persist the selected language)
 *
 * Lifecycle:
 * - Instantiated once in main.dart via MultiProvider
 * - Lives for the entire app session
 *
 * Author: Nohimitsu
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'locales/en.dart';
import 'locales/th.dart';

/// Manages the active locale and provides all localised content.
///
/// Fields:
/// - _currentLocale: the currently active [Locale]
/// - _content: static map of all EN/TH string and data content
///
/// Usage:
/// - Provided globally via [MultiProvider] in main.dart
/// - Consumed by screens via [Provider.of] or [Consumer]
class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  Locale get currentLocale => _currentLocale;

  // structured content — locale data lives in locales/en.dart and locales/th.dart
  static final Map<String, Map<String, dynamic>> _content = {
    'en': enContent,
    'th': thContent,
  };


  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    // ดึงค่าภาษาที่เคยบันทึกไว้
    final savedLanguage = prefs.getString('selected_language');

    if (savedLanguage != null) {
      // ถ้าผู้ใช้เคยเลือกภาษาไว้แล้ว ให้ใช้ภาษานั้น
      _currentLocale = Locale(savedLanguage);
    } else {
      // ถ้ายังไม่เคยเลือก (เข้าแอปครั้งแรก) ให้ดึงภาษาจากระบบเครื่อง
      final systemLanguageCode =
          ui.PlatformDispatcher.instance.locale.languageCode;

      // ถ้าเครื่องเป็นภาษาไทย ให้ใช้ 'th' นอกนั้นให้บังคับเป็น 'en'
      if (systemLanguageCode == 'th') {
        _currentLocale = const Locale('th');
      } else {
        _currentLocale = const Locale('en');
      }
    }

    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'selected_language', languageCode);

    notifyListeners();
  }

  // void changeLanguage(String languageCode) {
  //   _currentLocale = Locale(languageCode);
  //   notifyListeners();
  // }

  // Helper to get text by section and key
  String translate(String section, String key) {
    return _content[_currentLocale.languageCode]?[section][key] ?? key;
  }

  // Helper to get tutorial pages list
  List<Map<String, dynamic>> getTutorialPages() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['tutorial_pages']);
  }

  // Helper to get quick guide cards list
  List<Map<String, dynamic>> getQuickGuideCards() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_cards'] ?? []);
  }
  // Helper to get CPR perform rules
  Map<String, dynamic> getPerformCprRules() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['cpr_perform_rules'] ?? {});
  }
  // Helper to get CPR not perform rules
  Map<String, dynamic> getNotPerformCprRules() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['cpr_not_perform_rules'] ?? {});
  }
  // Helper to get quick guide age select
  Map<String, String> getQuickGuideAgeSelect() {
    return Map<String, String>.from(
        _content[_currentLocale.languageCode]?['quick_guide_age_select'] ?? {});
  }
  // Helper to get quick guide adult CPR
  List<Map<String, dynamic>> getQuickGuideAdultCpr() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_adult_cpr'] ?? []);
  }
  // Helper to get quick guide child CPR
  List<Map<String, dynamic>> getQuickGuideChildCpr() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_child_cpr'] ?? []);
  }
  // Helper to get quick test questions
  List<Map<String, dynamic>> getQuickTestQuestions() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_test_questions'] ?? []);
  }
  // Helper to get terms page
  Map<String, dynamic> getTermsPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['terms_page'] ?? {});
  }
  // Helper to get privacy page
  Map<String, dynamic> getPrivacyPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['privacy_page'] ?? {});
  }
  // Helper to get medical reference page
  Map<String, dynamic> getMedicalRefPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['medical_ref_page'] ?? {});
  }
  // Helper to get help page
  Map<String, dynamic> getHelpPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['help_page'] ?? {});
  }
}
