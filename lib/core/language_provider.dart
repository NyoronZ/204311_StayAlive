import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en'); 

  Locale get currentLocale => _currentLocale;

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'start': 'START',
      'emergency': 'Emergency',
      'others': 'Others',
      'quick_guide': 'Quick guide',
      'emergency_call': 'Emergency call',
      'find_hospital': 'Find hospital',
      'quick_test': 'Quick test',
      'tutorials': 'Tutorials',
      'settings': 'Settings',
    },
    'th': {
      'start': 'เริ่มใช้งาน',
      'emergency': 'ฉุกเฉิน',
      'others': 'อื่นๆ',
      'quick_guide': 'คู่มือด่วน',
      'emergency_call': 'โทรฉุกเฉิน',
      'find_hospital': 'ค้นหาโรงพยาบาล',
      'quick_test': 'แบบทดสอบ',
      'tutorials': 'บทเรียน',
      'settings': 'ตั้งค่า',
    },
  };

  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  String translate(String key) {
    return _localizedValues[_currentLocale.languageCode]?[key] ?? key;
  }
}