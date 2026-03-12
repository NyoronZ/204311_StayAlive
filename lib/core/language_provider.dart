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
          'desc':
              'STAYALIVE is your quick, reliable CPR guide designed for emergencies when every second counts.',
          'feat1': 'Instant\nGuidance',
          'feat2': 'Easy using',
          'feat3': 'Minimal\ndesigns',
        },
        {
          'title': 'Continue Until Help Arrives',
          'desc':
              'Continue CPR until emergency medical services arrive, an AED is available, or the person shows signs of life.',
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
          'description':
              'Ensure the surrounding area is safe for both you and the victim.',
          'keyPoints': [
            'Check for any danger.',
            'Do not move the victim unless necessary.',
          ],
        },
        {
          'number': '2',
          'title': 'Check for response',
          'description':
              'Tap the victim\'s shoulder and ask loudly, \'Are you okay?\'',
          'keyPoints': [
            'Ask the victim.',
            'Gently shake the victim.',
          ],
        },
        {
          'number': '3',
          'title': 'Check symptoms',
          'description':
              'Observe the victim\'s initial symptoms visually or through physical responses.',
        },
      ],
      'quick-guide': {
        'key-points': 'Key points:',
        'call_instruction': 'Press the button then return to the app',
      },
      'quick-guide-symptoms': {
        'title': 'Patient\'s Symptoms',
        'instruction': 'Press the button if you observe any of these symptoms',
        'sym_unconscious': 'Unconscious',
        'sym_abnormal_breathing': 'Abnormal breathing',
        'sym_severe_bleeding': 'Severe bleeding',
        'sym_convulsion': 'Convulsion',
      },
      'emergency_call': {
        'title': 'Emergency Call',
        'medical_th': 'Medical in Thailand >',
        'med_1196': '1196 - When encountering water accidents',
        'med_1554': '1554 - Vajira Hospital Rescue Unit',
        'med_1669': '1669 - National Institute for Emergency Medicine',
        'med_1691': '1691 - Police General Hospital',
        'others': 'Others >',
        'other_191': '191 - Police Emergency',
        'other_199': '199 - Fire Emergency',
        'other_1193': '1193 - Highway Police',
        'call_now': 'Emergency Call',
        'scroll_down': 'Scroll down to go to home page',
      },
      'cpr': {
        // Select Age
        'select_age_title': 'Select Patient Age',
        'infant': 'Infant',
        'infant_sub': 'Under 1 year',
        'child': 'Child',
        'child_sub': '1-8 years',
        'adult': 'Adult',
        'adult_sub': 'Over 8 years',
        'emergency_call': 'Emergency call',
        'next_step': 'Next Step',
        // Prep Guide
        'remember': 'Remember',
        'rescue_breaths': 'Rescue Breaths',
        'prep_infant_sub': 'Give 2 small breaths, when heard a signal',
        'prep_infant_ch1': 'Place 2 fingers just below nipple line',
        'prep_infant_ch2': 'Use 1 or 2 hands depending on child size',
        'prep_infant_ch3': 'Compress at least 1.5 inches or 3 centimeters deep',
        'prep_child_sub': 'Give 2 breaths, when heard a signal',
        'prep_child_ch1': 'Place heel of 1 or 2 hands on center of chest',
        'prep_child_ch2': 'Compress about 2 inches or 5 centimeters deep',
        'prep_child_ch3': 'Push hard and fast',
        'prep_adult_sub': 'Give 2 breaths, when heard a signal',
        'prep_adult_ch1': 'Place heel of 2 hands on center of chest',
        'prep_adult_ch2': 'Compress at least 2 inches or 5 centimeters deep',
        'prep_adult_ch3': 'Push hard and fast',
        'start_cpr': 'START CPR',
        // Timer
        'give_breaths': 'Give 2 small breaths',
        'push_depth': 'Push Depth',
        'depth_infant': 'Infant: ~3 cm',
        'depth_child': 'Child: ~5 cm',
        'depth_adult': 'Adult: ~5 cm',
        'compressions': 'Compressions:',
        'cycle': 'Cycle',
        'until_breath': 'compressions until breath',
        'cpr_in_progress': 'CPR in progress',
        'continue_btn': 'Continue',
        'complete_session': 'Complete Session',
        'get_ready': 'Get Ready',
        // Success
        'success': 'Success!',
        'speed': 'Speed',
        'age': 'Age',
        'time': 'Time',
        'full_cycles': 'Full Cycles',
        'done': 'Done',
      },
      'find_hospital_sec': {
        'title': 'Find Hospital',
        'search': 'search',
        'search_hint': 'Search hospital',
        'near_me': 'Hospitals near me >',
        'select_dest': 'select the destination',
        'your_position': 'your position',
        'scroll_down': 'Scroll down to go to home page',
        'loc_fetching': 'Finding your location...',
        'hosp_fetching': 'Searching for nearby hospitals...',
        'no_hosp': 'No hospitals found nearby (10km)',
        'loc_denied': 'Location permission denied',
        'open_map': 'Open Maps',
        'km': 'km',
        'loc_permission_title': 'Location Access Required',
        'loc_permission_desc': 'The app needs GPS to find and show the nearest hospitals to your current location.',
        'loc_permission_btn': 'Allow / Enable GPS',
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
          'desc':
              'STAYALIVE คือคู่มือทำ CPR ที่รวดเร็วและเชื่อถือได้ ออกแบบมาเพื่อสถานการณ์ฉุกเฉินที่ทุกวินาทีมีค่า',
          'feat1': 'คำแนะนำ\nทันที',
          'feat2': 'ใช้งานง่าย',
          'feat3': 'ดีไซน์\nเรียบง่าย',
        },
        {
          'title': 'ทำต่อไปจนกว่าความช่วยเหลือจะมาถึง',
          'desc':
              'ทำ CPR ต่อไปจนกว่าทีมกู้ชีพจะมาถึง มีเครื่อง AED พร้อมใช้งาน หรือผู้ป่วยมีการตอบสนอง',
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
          'description':
              'ตรวจสอบความปลอดภัยของสถานที่รอบตัวทั้งคุณและผู้บาดเจ็บ',
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
          'description':
              'ตรวจสอบอาการเบื้องต้นของผู้ป่วยจากการมอง หรือการตอบสนองทางกายภาพ',
        },
      ],
      'quick-guide': {
        'key-points': 'จุดสำคัญ:',
        'call_instruction': 'ให้กดปุ่ม แล้วกลับเข้าแอพ',
      },
      'quick-guide-symptoms': {
        'title': 'อาการของผู้ป่วย',
        'instruction': 'กดปุ่มหากพบอาการ',
        'sym_unconscious': 'ไม่รู้สึกตัว',
        'sym_abnormal_breathing': 'หายใจผิดปกติ',
        'sym_severe_bleeding': 'มีเลือดออกมาก',
        'sym_convulsion': 'ชักกระตุก',
      },
      'emergency_call': {
        'title': 'Emergency Call',
        'medical_th': 'ด้านการแพทย์ในไทย >',
        'med_1196': '1196 – เมื่อพบเจออุบัติเหตุทางน้ำ',
        'med_1554': '1554 – หน่วยแพทย์กู้ชีวิต วชิรพยาบาล',
        'med_1669': '1669 – สถาบันการแพทย์ฉุกเฉินแห่งชาติ',
        'med_1691': '1691 – โรงพยาบาลตำรวจ',
        'others': 'อื่นๆ >',
        'other_191': '191 – เหตุด่วนเหตุร้าย ตำรวจ',
        'other_199': '199 – แจ้งเหตุไฟไหม้',
        'other_1193': '1193 – สายด่วนจราจร',
        'call_now': 'โทรฉุกเฉิน',
        'scroll_down': 'เลื่อนลงเพื่อไปยังหน้าหลัก',
      },
      'cpr': {
        // Select Age
        'select_age_title': 'เลือกระยะอายุของผู้ป่วย',
        'infant': 'ทารก',
        'infant_sub': 'อายุต่ำกว่า 1 ปี',
        'child': 'เด็ก',
        'child_sub': 'อายุ 1-8 ปี',
        'adult': 'ผู้ใหญ่',
        'adult_sub': 'อายุมากกว่า 8 ปี',
        'emergency_call': 'โทรฉุกเฉิน',
        'next_step': 'ขั้นตอนถัดไป',
        // Prep Guide
        'remember': 'จำไว้',
        'rescue_breaths': 'การเป่าลมหายใจ',
        'prep_infant_sub': 'เป่าลมเบาๆ 2 ครั้ง เมื่อได้ยินสัญญาณ',
        'prep_infant_ch1': 'วางนิ้ว 2 นิ้วที่ตรงกลางหน้าอก',
        'prep_infant_ch2': 'ใช้ 1 หรือ 2 มือ ขึ้นอยู่กับขนาดของเด็ก',
        'prep_infant_ch3': 'กดลึกอย่างน้อย 1.5 นิ้ว หรือ 3 เซนติเมตร',
        'prep_child_sub': 'เป่าลม 2 ครั้ง เมื่อได้ยินสัญญาณ',
        'prep_child_ch1': 'วางส้นมือ 1 หรือ 2 มือที่ตรงกลางหน้าอก',
        'prep_child_ch2': 'กดลึกประมาณ 2 นิ้ว หรือ 5 เซนติเมตร',
        'prep_child_ch3': 'กดให้เร็วและแรง',
        'prep_adult_sub': 'เป่าลม 2 ครั้ง เมื่อได้ยินสัญญาณ',
        'prep_adult_ch1': 'วางส้นมือ 2 มือที่ตรงกลางหน้าอก',
        'prep_adult_ch2': 'กดลึกอย่างน้อย 2 นิ้ว หรือ 5 เซนติเมตร',
        'prep_adult_ch3': 'กดให้เร็วและแรง',
        'start_cpr': 'เริ่ม CPR',
        // Timer
        'give_breaths': 'เป่าลมเบาๆ 2 ครั้ง',
        'push_depth': 'ความลึกในการกด',
        'depth_infant': 'ทารก: ~3 ซม.',
        'depth_child': 'เด็ก: ~5 ซม.',
        'depth_adult': 'ผู้ใหญ่: ~5 ซม.',
        'compressions': 'จำนวนการกด:',
        'cycle': 'รอบ',
        'until_breath': 'ครั้งจนกว่าจะเป่าลม',
        'cpr_in_progress': 'กำลังทำ CPR',
        'continue_btn': 'ทำต่อ',
        'complete_session': 'จบการกระทำ CPR',
        'get_ready': 'เตรียมพร้อม',
        // Success
        'success': 'สำเร็จ!',
        'speed': 'ความเร็ว',
        'age': 'อายุ',
        'time': 'เวลา',
        'full_cycles': 'รอบสมบูรณ์',
        'done': 'เสร็จสิ้น',
      },
      'find_hospital_sec': {
        'title': 'Find Hospital',
        'search': 'search',
        'search_hint': 'ค้นหาโรงพยาบาล',
        'near_me': 'โรงพยาบาลใกล้ฉัน >',
        'select_dest': 'select the destination',
        'your_position': 'your position',
        'scroll_down': 'เลื่อนลงเพื่อไปยังหน้าหลัก',
        'loc_fetching': 'กำลังค้นหาตำแหน่งของคุณ...',
        'hosp_fetching': 'กำลังค้นหาโรงพยาบาลใกล้เคียง...',
        'no_hosp': 'ไม่พบโรงพยาบาลในรัศมี (10กม.)',
        'loc_denied': 'ไม่ได้รับอนุญาตให้เข้าถึงตำแหน่ง',
        'open_map': 'เปิดแผนที่',
        'km': 'กม.',
        'loc_permission_title': 'ต้องการเข้าถึงพิกัดของคุณ',
        'loc_permission_desc': 'แอปจำเป็นต้องใช้สัญญาณ GPS เพื่อค้นหาและแสดงรายการโรงพยาบาลที่อยู่ใกล้คุณที่สุดในขณะนี้',
        'loc_permission_btn': 'อนุญาต / เปิดใช้งาน GPS',
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
    return List<Map<String, String>>.from(
        _content[_currentLocale.languageCode]?['tutorial_pages']);
  }

  // Helper to get quick guide cards list
  List<Map<String, dynamic>> getQuickGuideCards() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_cards'] ?? []);
  }
}
