import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  Locale get currentLocale => _currentLocale;

  // structured content
  static const Map<String, Map<String, dynamic>> _content = {
    'en': {
      'common': {
        'skip': 'skip >',
        'next': 'Next',
        'start_btn': 'Let\'s Get Started!',
        'settings': 'Settings'
      },
      'home': {
        'start': 'START',
        'emergency': 'Emergency',
        'others': 'Others',
        'quick_guide': 'Quick guide',
        'emergency_call': 'Emergency call',
        'find_hospital': 'Find hospital',
        'quick_test': 'Quick test',
        'tutorials': 'Tutorials',
      },
      'tutorial_pages': [
        {
          'title': 'What is STAYALIVE?',
          'desc': 'STAYALIVE is your quick, reliable CPR guide designed for emergencies when every second counts.',
          'feat1': 'Instant\nGuidance',
          'feat2': 'Easy using',
          'feat3': 'Minimal\ndesigns',
        },
        {
          'title': 'Continue Until Help Arrives',
          'desc': 'Continue CPR until emergency medical services arrive, an AED is available, or the person shows signs of life.',
          'feat1': 'Don\'t stop',
          'feat2': 'Switch rescuer',
          'feat3': 'Use AED',
        },
      ],
      'settings': {
        'title': 'Settings',
        'user_sec': 'user',
        'notifications': 'Notifications',
        'config': 'Configuration',
        'privacy': 'Privacy',
        'language': 'Language',
        'support_sec': 'supporting',
        'help': 'Help',
        'feedback': 'Feedback',
        'terms': 'Terms and Conditions of Service',
        'privacy_pol': 'Privacy Policy',
        'medical_ref': 'Medical References',
        'select_lang': 'Select Language',
      },
      'quick_guide_cards': [
        {
          'number': '1',
          'title': 'Check the scene',
          'description': 'Ensure the surrounding area is safe for both you and the victim.',
          'keyPoints': [
            'Check for any danger.',
            'Do not move the victim unless necessary.',
          ],
        },
        {
          'number': '2',
          'title': 'Check for response',
          'description': 'Tap the victim\'s shoulder and ask loudly, \'Are you okay?\'',
          'keyPoints': [
            'Ask the victim.',
            'Gently shake the victim.',
          ],
        },
        {
          'number': '3',
          'title': 'Check symptoms',
          'description': 'Observe the victim\'s initial symptoms visually or through physical responses.',
        },
      ],
      'quick-guide': {
        'key-points': 'Key points:',
      },
    },
    'th': {
      'common': {
        'skip': 'ข้าม >',
        'next': 'ถัดไป',
        'start_btn': 'เริ่มใช้งานกันเลย!',
        'settings': 'ตั้งค่า'
      },
      'home': {
        'start': 'เริ่มใช้งาน',
        'emergency': 'ฉุกเฉิน',
        'others': 'อื่นๆ',
        'quick_guide': 'คู่มือด่วน',
        'emergency_call': 'โทรฉุกเฉิน',
        'find_hospital': 'ค้นหาโรงพยาบาล',
        'quick_test': 'แบบทดสอบ',
        'tutorials': 'บทเรียน',
      },
      'tutorial_pages': [
        {
          'title': 'STAYALIVE คืออะไร?',
          'desc': 'STAYALIVE คือคู่มือทำ CPR ที่รวดเร็วและเชื่อถือได้ ออกแบบมาเพื่อสถานการณ์ฉุกเฉินที่ทุกวินาทีมีค่า',
          'feat1': 'คำแนะนำ\nทันที',
          'feat2': 'ใช้งานง่าย',
          'feat3': 'ดีไซน์\nเรียบง่าย',
        },
        {
          'title': 'ทำต่อไปจนกว่าความช่วยเหลือจะมาถึง',
          'desc': 'ทำ CPR ต่อไปจนกว่าทีมกู้ชีพจะมาถึง มีเครื่อง AED พร้อมใช้งาน หรือผู้ป่วยมีการตอบสนอง',
          'feat1': 'ห้ามหยุด',
          'feat2': 'สลับคนปั๊ม',
          'feat3': 'ใช้ AED',
        },
      ],
      'settings': {
        'title': 'การตั้งค่า',
        'user_sec': 'ผู้ใช้งาน',
        'notifications': 'การแจ้งเตือน',
        'config': 'การกำหนดค่า',
        'privacy': 'ความเป็นส่วนตัว',
        'language': 'ภาษา',
        'support_sec': 'การสนับสนุน',
        'help': 'ช่วยเหลือ',
        'feedback': 'ข้อเสนอแนะ',
        'terms': 'ข้อกำหนดและเงื่อนไขการใช้บริการ',
        'privacy_pol': 'นโยบายความเป็นส่วนตัว',
        'medical_ref': 'อ้างอิงทางการแพทย์',
        'select_lang': 'เลือกภาษา',
      },
      'quick_guide_cards': [
        {
          'number': '1',
          'title': 'ตรวจสอบพื้นที่',
          'description': 'ตรวจสอบความปลอดภัยของสถานที่รอบตัวทั้งคุณและผู้บาดเจ็บ',
          'keyPoints': [
            'ตรวจสอบว่ามีอันตรายหรือไม่',
            'อย่าย้ายผู้ป่วยถ้าไม่จำเป็น',
          ],
        },
        {
          'number': '2',
          'title': 'ตรวจการตอบสนอง',
          'description': 'เช็คการตอบสนอง แตะไหล่ผู้ป่วยแล้วถามว่า \'โอเคไหม?\'',
          'keyPoints': [
            'ถามผู้ป่วย',
            'เขย่าตัวของผู้ป่วยเบาๆ',
          ],
        },
        {
          'number': '3',
          'title': 'เช็คอาการ',
          'description': 'ตรวจสอบอาการเบื้องต้นของผู้ป่วยจากการมอง หรือการตอบสนองทางกายภาพ',
        },
      ],
      'quick-guide': {
        'key-points': 'จุดสำคัญ:',
      },
    },
  };

  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  // Helper to get text by section and key
  String translate(String section, String key) {
    return _content[_currentLocale.languageCode]?[section][key] ?? key;
  }

  // Helper to get tutorial pages list
  List<Map<String, String>> getTutorialPages() {
    return List<Map<String, String>>.from(_content[_currentLocale.languageCode]?['tutorial_pages']);
  }

  // Helper to get quick guide cards list
  List<Map<String, dynamic>> getQuickGuideCards() {
    return List<Map<String, dynamic>>.from(_content[_currentLocale.languageCode]?['quick_guide_cards'] ?? []);
  }
}