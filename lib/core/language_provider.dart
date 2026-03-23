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
          'title': 'Start CPR',
          'desc':
              'Interactive CPR guidance to assist you during an emergency. Provides audio cues and metronome to maintain the correct rhythm.',
          'feat1': 'Select Age',
          'feat2': 'Metronome',
          'feat3': 'Timer',
        },
        {
          'title': 'Quick Guide',
          'desc':
              'A fast and easy-to-follow guide for checking the scene, assessing the patient, and checking symptoms before acting.',
          'feat1': 'Check Scene',
          'feat2': 'Response',
          'feat3': 'Symptoms',
        },
        {
          'title': 'Emergency Call',
          'desc':
              'Quickly reach professional help with our emergency call feature. Access local medical emergency numbers with one simple tap.',
          'feat1': 'Fast Dial',
          'feat2': 'Local nums',
          'feat3': 'Location',
        },
        {
          'title': 'Quick Test',
          'desc':
              'Challenge your knowledge with interactive scenarios to ensure you are ready when it matters most.',
          'feat1': 'Quizzes',
          'feat2': 'Scenarios',
          'feat3': 'Feedback',
        },
        {
          'title': 'Continue Until Help Arrives',
          'desc':
              'Continue CPR until emergency medical services arrive, an AED is available, or the person shows signs of life.',
          'image': 'assets/images/people_in_med.png',
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
        'terms': 'Terms and Conditions of Service',
        'privacy_pol': 'Privacy Policy',
        'medical_ref': 'Medical References',
        'select_lang': 'Select Language',
        'display_sec': 'configuration',
        'dark_mode': 'Dark Mode',
        'text_size': 'Text Size',
        'loc_permission': 'Location Permission',
        'loc_permission_desc':
            'Allow the app to access your location to find nearby hospitals.',
        'accept_terms': 'Terms and Conditions',
        'accept_terms_desc':
            'Accepting the terms is required to use the application.',
        'revoke_title': 'Revoke Terms?',
        'revoke_desc':
            'If you revoke your acceptance of the Terms and Conditions, the app will close and you will need to accept them again to use the application.',
        'cancel': 'Cancel',
        'revoke_btn': 'Revoke and Close',
        'loc_required': 'Location permission required.',
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
      'quick_guide_age_select': {
        'title': 'Select Patient Age',
        'desc': 'Choose the age group below to see proper CPR steps.',
        'adult': 'Adult (>8 years)',
        'infant_child': 'Infant & Child (<8 yrs)',
        'selected_prefix': 'Selected Age:',
        'change': 'Change',
      },
      'quick_guide_adult_cpr': [
        {
          'number': '5',
          'title': 'Open airway',
          'description': 'Tilt their head back slightly by lifting their chin.',
        },
        {
          'number': '6',
          'title': 'Check breathing',
          'description':
              'Listen for max 10s. If they are not breathing, start CPR.',
        },
        {
          'number': '7',
          'title': '30 Compressions',
          'description':
              'Push hard and fast (2 inches deep, 100-120/min) in the center of the chest.',
        },
        {
          'number': '8',
          'title': '2 Rescue Breaths',
          'description':
              'Pinch nose shut. Place mouth over theirs. Blow to make the chest rise.',
        },
        {
          'number': '9',
          'title': 'Repeat',
          'description':
              'Repeat 30 compressions and 2 breaths until help arrives or AED is ready.',
        },
      ],
      'quick_guide_child_cpr': [
        {
          'number': '5',
          'title': 'Open airway',
          'description': 'Tilt their head back slightly by lifting their chin.',
        },
        {
          'number': '6',
          'title': 'Check breathing',
          'description':
              'Listen for max 10s. If they are not breathing, start CPR.',
        },
        {
          'number': '7',
          'title': '2 Rescue Breaths',
          'description':
              'Child: Blow into mouth twice.\nInfant: Cover mouth & nose, blow twice.',
        },
        {
          'number': '8',
          'title': '30 Compressions',
          'description':
              'Child: 1 hand, ~2 inches deep.\nInfant: 2 fingers, ~1.5 inches deep.',
        },
        {
          'number': '9',
          'title': 'Repeat',
          'description':
              'Repeat 30 compressions and 2 breaths until help arrives.',
        },
      ],
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
        'return_reminder':
            'After making the emergency call, don\'t forget to return to the app',
      },
      'cpr': {
        'cpr_title': 'CPR',
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
        'success_title': 'Result',
        'success': 'Success!',
        'speed': 'Speed',
        'age': 'Age',
        'time': 'Time',
        'full_cycles': 'Full Cycles',
        'done': 'Done',
      },
      'find_hospital_sec': {
        'title': 'Find Hospital',
        'search': 'Search',
        'search_hint': 'Search hospital',
        'near_me': 'Hospitals near me >',
        'select_dest': 'Select the destination',
        'your_position': 'Your position',
        'scroll_down': 'Scroll down to go to home page',
        'loc_fetching': 'Finding your location...',
        'hosp_fetching': 'Searching for nearby hospitals...',
        'no_hosp': 'No hospitals found nearby (10km)',
        'loc_denied': 'Location permission denied',
        'open_map': 'Open Maps',
        'km': 'km',
        'loc_permission_title': 'Location Access Required',
        'loc_permission_desc':
            'The app needs GPS to find and show the nearest hospitals to your current location.',
        'loc_permission_btn': 'Allow / Enable GPS',
        'try_again': 'Try again',
        'app_settings_needed':
            'Please allow location access in your phone settings',
        'no_coordinates':
            'Unable to determine coordinates\nPlease try again in an open area',
        'server_error': 'Server returned an error. Please try again',
        'connection_error':
            'An error occurred while connecting to the internet',
      },
      'cpr_conditions': {
        'title_when_cpr': 'Patient\'s Symptoms',
        'instruction': 'Press the button if you observe any of these symptoms',
        'cardiac_arrest': 'Cardiac Arrest',
        'unconsciousness': 'Unconsciousness',
        'choking': 'Choking',
        'severe_trauma': 'Severe Trauma',
        'drug_overdose': 'Drug Overdose',
        'drowning': 'Drowning',
        'electric_shock': 'Electric Shock',
        'not_breathing': 'Not Breathing',
        'severe_allergic_reaction': 'Severe Allergic Reaction',
        'toxic_gas_smoke': 'Toxic Gas or Smoke',
      },
      'cpr_required': {
        'title': 'CPR REQUIRED',
        'follow_steps': 'Follow these steps',
        'symptoms': 'Symptoms:',
        'press_button': 'Press the button then return to the app',
      },
      'cpr_perform_rules': {
        'title': 'When Should You Perform CPR?',
        'desc':
            'Cardiopulmonary resuscitation is a life-saving technique used in emergencies when someone’s breathing or heartbeat has stopped.',
        'list_items': [
          {
            'title': '1. Cardiac Arrest',
            'desc':
                'Heart suddenly stops beating. Immediate CPR is crucial to maintain blood flow to brain and organs until help arrives.'
          },
          {
            'title': '2. Unconsciousness',
            'desc':
                'When someone cannot react and breathe normally due to severe conditions.'
          },
          {
            'title': '3. Choking',
            'desc':
                'Complete respiratory arrest caused by choking or severe trauma.'
          },
          {
            'title': '4. Severe Trauma',
            'desc':
                'Intense injuries disrupting normal heart rhythms or damaging lungs.'
          },
          {
            'title': '5. Drug Overdose',
            'desc':
                'Substances overwhelming the body, leading to slowed breathing and cardiac arrest.'
          },
          {
            'title': '6. Drowning',
            'desc':
                'Body may stop breathing because water fills the lungs. Watch out for secondary drowning.'
          },
          {
            'title': '7. Electric Shock',
            'desc':
                'Electric current interfering with heart signals. Immediate CPR maintains blood flow.'
          },
        ]
      },
      'cpr_not_perform_rules': {
        'title': 'When Should You Not Do CPR?',
        'desc':
            'If someone is awake and breathing, they don’t need CPR. There are also certain situations where you shouldn’t give CPR.',
        'list_items': [
          {
            'title': '1. Obvious Signs of Death',
            'desc':
                'Signs like rigor mortis or severe injuries where CPR would be futile.'
          },
          {
            'title': '2. Do Not Resuscitate (DNR) Orders',
            'desc': 'A legal document specifying a person’s wish to forgo CPR.'
          },
          {
            'title': '3. Unsafe Environment',
            'desc':
                'Hazardous environments like fire or toxic fumes. Ensure safety first.'
          },
          {
            'title': '4. Medical Conditions',
            'desc': 'Terminal illness or palliative care focusing on comfort.'
          },
          {
            'title': '5. Professional Assessment',
            'desc':
                'When medical professionals determine CPR would be ineffective.'
          },
        ]
      },
      'how_to_cpr_screen': {
        'adult_cpr': 'Adult CPR',
        'adult_step1_title': 'Step 1. Call 911',
        'adult_step1_desc':
            'First, check the scene for factors that could endanger you, such as traffic, fire, or falling masonry. Next, check the person. Do they need help? Tap their shoulder and shout, "Are you OK?"\n\nIf they are not responding, call 911 or ask a bystander to call 911 before performing CPR. If possible, ask a bystander to go and search for an AED machine. People can find these in offices and many other public buildings.',
        'adult_step2_title':
            'Step 2. Place the person on their back and open their airway',
        'adult_step2_desc':
            'Place the person carefully on their back and kneel beside their chest. Tilt their head back slightly by lifting their chin.\n\nOpen their mouths and check for obstructions, such as food or vomit. If an obstruction is loose, remove it. Trying to grasp it may push it farther into the airway if it is not loose.',
        'adult_step3_title': 'Step 3. Check for breathing',
        'adult_step3_desc':
            'Place your ear next to the person\'s mouth and listen for no more than 10 seconds. If you do not hear breathing or you only hear occasional gasps, begin CPR.\n\nIf someone is unconscious but still breathing, do not perform CPR. Instead, if they do not seem to have a spinal injury, place them in the recovery position. Keep monitoring their breathing and perform CPR if they stop breathing.',
        'cpr_steps_title': 'CPR Steps',
        'adult_step4_title': 'Step 4. Perform 30 chest compressions',
        'adult_step4_desc':
            'Place one of your hands on the other and clasp them together. With the heel of the hands and straight elbows, push hard and fast in the center of the chest, slightly below the nipples.\n\nPush at least 2 inches deep. Compress their chest at a rate of at least 100 times per minute, letting the chest rise fully between compressions.',
        'adult_step5_title': 'Step 5. Perform two rescue breaths',
        'adult_step5_desc':
            'Ensure their mouth is clear, tilt their head slightly, and lift their chin. Pinch their nose shut, place your mouth entirely over theirs, and blow to raise their chest.\n\nIf the person\'s chest does not rise with the first breath, tilt their head. If it still does not rise with the second breath, the person might be choking.',
        'adult_step6_title': 'Step 6. Repeat',
        'adult_step6_desc':
            'Repeat the cycle of 30 chest compressions and two rescue breaths until the person starts breathing or help arrives. If an AED arrives, carry on performing CPR until the machine is set up and ready to use.',
        'child_cpr_title': 'CPR for children and infants: Step by step',
        'child_cpr_desc':
            'The CPR steps for children and infants differ slightly from those for adults, as shown below.',
        'child_bullet1':
            'For children: tap their shoulders and shout, "Are you OK?"',
        'child_bullet2':
            'For infants: flick the sole of their feet to see if they respond.',
        'child_step1_title': 'Step 1. Call 911 or give 2 minutes of care',
        'child_step1_desc':
            'If you are alone with the child and they are not responding, give them 2 minutes of care and then call 911. If there is a bystander, ask them to call 911 while you give 2 minutes of care.\n\nIf the child does respond, call 911 to report any life threatening conditions.',
        'child_step2_title':
            'Step 2. Place them on their back and open their airways',
        'child_step2_desc':
            'Place the child or infant on their back and kneel beside their chest. Tilt their head backward slightly by lifting their chin.\n\nCheck for any obstruction. If it is loose, remove it. Do not touch it if it is not loose.',
        'child_step3_title': 'Step 3. Check for breathing',
        'child_step3_desc':
            'Listen for around 10 seconds. Changes in an infant\'s breathing patterns are normal, as they usually have periodic breathing.\n\nKeep monitoring their breathing and perform CPR if they stop breathing.',
        'child_step4_title': 'Step 4. Perform two rescue breaths',
        'child_step4_desc':
            'If they are not breathing, perform two rescue breaths.\n\n• For a child: pinch their nose shut and place your mouth over theirs. Breathe into their mouth twice.\n• For an infant: place your mouth over their nose and mouth and blow for 1 second to make their chest rise. Then, deliver two rescue breaths.',
        'child_step5_title': 'Step 5. Perform 30 chest compressions',
        'child_step5_desc':
            'Kneel beside the child or infant.\n\n• For a child: use one of your hands. Place the heel of the hand at their sternum. Press down hard and fast around 2 inches deep, at least 100 times per minute.\n• For an infant: use two fingers. Place your fingers in the center of their chest, between and slightly below the nipples. Perform 30 quick compressions around 1.5 inches deep.',
        'child_step6_title': 'Step 6. Repeat',
        'child_step6_desc':
            'Repeat the cycle of rescue breaths and chest compressions until the child starts breathing or help arrives.',
      },
      'quick_test_screen': {
        'title': 'Quick Test',
        'next': 'Next',
        'previous': 'Previous',
        'finish': 'Finish',
        'explanation': 'Explanation:',
        'correct': 'Correct!',
        'incorrect': 'Incorrect!',
        'result_title': 'Test Results',
        'score': 'Your Score:',
        'try_again': 'Try Again',
      },
      'quick_test_questions': [
        {
          'question':
              'What is the correct compression-to-ventilation ratio for adult CPR when performing two-rescuer CPR?',
          'options': ['15:2', '30:2', '20:1', '10:2'],
          'answerIndex': 1,
          'explanation':
              'For adult CPR with two rescuers, the ratio is 30 chest compressions to 2 rescue breaths, allowing for effective circulation and oxygenation.'
        },
        {
          'question':
              'In which situation should CPR be started immediately without checking for a pulse?',
          'options': [
            'A conscious adult with chest pain',
            'An unresponsive adult who is not breathing normally',
            'A child with a minor injury',
            'An infant who is crying'
          ],
          'answerIndex': 1,
          'explanation':
              'If an adult is unresponsive and not breathing normally, begin CPR immediately, as delays can reduce survival chances.'
        },
        {
          'question':
              'What is the recommended depth for chest compressions in an adult during CPR?',
          'options': [
            'At least 2 inches (5 cm)',
            'At least 1 inch (2.5 cm)',
            'At least 3 inches (7.5 cm)',
            'At least 4 inches (10 cm)'
          ],
          'answerIndex': 0,
          'explanation':
              'Compressions should be at least 2 inches deep to effectively pump blood through the heart and to the body.'
        },
        {
          'question':
              'How should you position your hands for chest compressions on an adult?',
          'options': [
            'On the lower half of the breastbone',
            'On the upper abdomen',
            'On the side of the chest',
            'On the neck'
          ],
          'answerIndex': 0,
          'explanation':
              'Place the heel of one hand on the center of the chest, on the lower half of the breastbone, to ensure compressions are effective.'
        },
        {
          'question':
              'What is the primary purpose of chest compressions in CPR?',
          'options': [
            'To provide oxygen to the lungs',
            'To maintain blood circulation to vital organs',
            'To clear airway blockages',
            'To monitor heart rhythm'
          ],
          'answerIndex': 1,
          'explanation':
              'Chest compressions manually pump blood from the heart to the brain and other organs, sustaining life until advanced help arrives.'
        },
        {
          'question':
              'When performing CPR on an infant, what is the correct rate for chest compressions?',
          'options': [
            '100-120 per minute',
            '60-80 per minute',
            '80-100 per minute',
            '120-140 per minute'
          ],
          'answerIndex': 0,
          'explanation':
              'The compression rate for infants is the same as for adults and children: 100-120 compressions per minute to maintain effective circulation.'
        },
        {
          'question': 'What should you do if the airway is blocked during CPR?',
          'options': [
            'Perform abdominal thrusts',
            'Give back blows',
            'Use the head-tilt, chin-lift maneuver',
            'Continue compressions without interruption'
          ],
          'answerIndex': 2,
          'explanation':
              'The head-tilt, chin-lift maneuver opens the airway; if it’s still blocked, reassess and continue CPR steps accordingly.'
        },
        {
          'question':
              'How long should you check for breathing in an unresponsive person before starting CPR?',
          'options': [
            'Up to 10 seconds',
            'Up to 1 minute',
            'Up to 30 seconds',
            'Up to 5 seconds'
          ],
          'answerIndex': 0,
          'explanation':
              'Check for breathing for no more than 10 seconds to quickly determine if CPR is needed and avoid unnecessary delays.'
        },
        {
          'question':
              'What is the correct order of the CPR sequence for an adult?',
          'options': [
            'Airway, Breathing, Compressions',
            'Compressions, Airway, Breathing',
            'Breathing, Compressions, Airway',
            'Compressions, Airway, Defibrillation'
          ],
          'answerIndex': 1,
          'explanation':
              'The C-A-B sequence (Compressions, Airway, Breathing) prioritizes circulation to prevent brain damage.'
        },
        {
          'question':
              'When using an AED on a child, what should you do if pediatric pads are not available?',
          'options': [
            'Do not use the AED',
            'Use adult pads if they do not touch each other',
            'Wait for professional help',
            'Use the pads on the back'
          ],
          'answerIndex': 1,
          'explanation':
              'If pediatric pads are unavailable, adult pads can be used on children as long as they do not overlap, to deliver the shock safely.'
        },
        {
          'question':
              'What is the recommended rescue breath volume for an adult during CPR?',
          'options': [
            'A full breath from your lungs',
            'Just enough to make the chest rise',
            'Two full breaths at once',
            'No breaths, only compressions'
          ],
          'answerIndex': 1,
          'explanation':
              'Give breaths that are just enough to make the chest rise, typically about 500-600 mL, to avoid over-inflation and gastric distension.'
        },
        {
          'question':
              'Why is it important to allow full chest recoil during CPR compressions?',
          'options': [
            'To rest the rescuer',
            'To ensure blood returns to the heart',
            'To check for breathing',
            'To adjust hand position'
          ],
          'answerIndex': 1,
          'explanation':
              'Full recoil allows the heart to refill with blood between compressions, maximizing blood flow and effectiveness of CPR.'
        },
        {
          'question':
              'For how long should you continue CPR until help arrives or the person shows signs of life?',
          'options': [
            'Until you are tired',
            'For 5 minutes',
            'Until emergency services take over',
            'For 10 minutes'
          ],
          'answerIndex': 2,
          'explanation':
              'Continue CPR until advanced medical help arrives, the person revives, or you are relieved by another rescuer.'
        },
        {
          'question':
              'What is a key difference in CPR for a child versus an adult?',
          'options': [
            'Use only one hand for compressions',
            'Check for a pulse for up to 60 seconds',
            'The compression depth is shallower',
            'Do not use an AED'
          ],
          'answerIndex': 2,
          'explanation':
              'For children, compressions should be about one-third the depth of the chest, typically 2 inches for older children, to avoid injury.'
        },
        {
          'question':
              'What should you do if you are alone and find an unresponsive adult?',
          'options': [
            'Start CPR immediately',
            'Call for help first, then start CPR',
            'Wait for witnesses',
            'Check for allergies'
          ],
          'answerIndex': 1,
          'explanation':
              'If alone, call emergency services or get an AED first, then begin CPR, to ensure help is on the way.'
        },
        {
          'question':
              'During two-rescuer CPR, how often should rescuers switch roles?',
          'options': [
            'Every 2 minutes',
            'Every 5 minutes',
            'Every 1 minute',
            'Never switch'
          ],
          'answerIndex': 0,
          'explanation':
              'Switching every 2 minutes helps maintain high-quality compressions by preventing rescuer fatigue.'
        },
        {
          'question':
              'What is the first action when you arrive at a scene where someone is unresponsive?',
          'options': [
            'Start chest compressions',
            'Ensure the scene is safe',
            'Give rescue breaths',
            'Use an AED'
          ],
          'answerIndex': 1,
          'explanation':
              'Check for scene safety first to protect yourself and avoid additional risks.'
        },
        {
          'question':
              'In CPR, what does the “A” in the C-A-B sequence stand for?',
          'options': ['Assessment', 'Airway', 'Assistance', 'AED'],
          'answerIndex': 1,
          'explanation':
              '“A” stands for Airway, which involves opening the airway to allow for effective breathing.'
        },
        {
          'question':
              'Why should you avoid interrupting chest compressions during CPR?',
          'options': [
            'To keep the rhythm steady',
            'To allow for rest periods',
            'To minimize blood flow interruptions',
            'To check for pulse'
          ],
          'answerIndex': 2,
          'explanation':
              'Interruptions reduce blood flow to vital organs, so aim for minimal pauses to improve survival rates.'
        },
        {
          'question':
              'What is the correct hand placement for CPR on an infant?',
          'options': [
            'Two fingers on the center of the chest',
            'Both hands on the abdomen',
            'One hand on the chest',
            'Fingers on the sides'
          ],
          'answerIndex': 0,
          'explanation':
              'For infants, use two fingers (index and middle) on the center of the chest, just below the nipple line, for effective compressions without causing injury.'
        },
      ],
      'terms_page': {
        'title': 'Terms of Service',
        'last_updated': 'Last Updated: March 2026',
        'sections': [
          {
            'title': '1. Acceptance of Terms',
            'body':
                'By downloading and using STAYALIVE, you agree to comply with and be bound by these Terms and Conditions.'
          },
          {
            'title': '2. Medical Disclaimer',
            'body':
                'STAYALIVE is a guidance tool and not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.'
          },
          {
            'title': '3. Location Access',
            'body':
                'To provide features such as "Find Hospital," the app may request access to your device\'s location. This information is used solely for the purpose of identifying nearby medical facilities and is not stored or shared for other purposes.'
          },
          {
            'title': '4. Limitation of Liability',
            'body':
                'In no event shall the developers of STAYALIVE be liable for any damages arising out of the use or inability to use the application.'
          }
        ]
      },
      'privacy_page': {
        'title': 'Privacy Policy',
        'last_updated': 'Last Updated: March 2026',
        'sections': [
          {
            'title': '1. Information We Collect',
            'body':
                'STAYALIVE is designed to respect your privacy. We do not require account registration. We may collect non-identifiable usage data to improve app performance.'
          },
          {
            'title': '2. Location Data',
            'body':
                'Location data is processed locally on your device to find nearby hospitals. We do not transmit or store your precise location on our servers.'
          },
          {
            'title': '3. Data Security',
            'body':
                'We implement standard security measures to protect any data processed by the app.'
          }
        ]
      },
      'medical_ref_page': {
        'title': 'Medical References',
        'desc':
            'STAYALIVE content is based on established emergency medical guidelines.',
        'reviewer': {
          'title': 'Medically reviewed by',
          'name': 'Carissa Stephens, R.N., CCRN, CPN',
          'author': 'by Amanda Barrell',
          'update_info':
              'Updated on January 9, 2026 from medical news web (www.medicalnewstoday.com)',
          'bio':
              'Carissa Stephens is a pediatric nurse, with a special expertise in extracorporeal membrane oxygenation (ECMO). She is currently a nurse in a pediatric intensive care unit at Dell Children\'s Medical Center of Central Texas.'
        },
        'references': [
          {
            'source': 'American Health Care Academy',
            'detail':
                'Certified CPR, First Aid, and Basic Life Support (BLS) training provider.'
          },
          {
            'source': 'American Heart Association (AHA)',
            'detail':
                'Guidelines for CPR and Emergency Cardiovascular Care (ECC).'
          },
          {
            'source':
                'International Liaison Committee on Resuscitation (ILCOR)',
            'detail':
                'International Consensus on CPR and ECC Science with Treatment Recommendations.'
          },
          {
            'source': 'Thai Red Cross Society',
            'detail': 'First Aid and CPR Training Guidelines for Thailand.'
          }
        ]
      },
      'help_page': {
        'title': 'Help Guide',
        'sections': [
          {
            'title': '1. Introduction & Tutorial',
            'body':
                'When users open the application, they will first encounter the tutorial screen (during the first-time use). This tutorial explains how to use the application and provides basic knowledge about CPR. After completing the tutorial, users will be directed to the main page. Users can press Skip to jump directly to the final step.'
          },
          {
            'title': '2. Getting Started',
            'body':
                'After the tutorial, the system will display the Terms and Conditions of Service page. Users must accept the terms before they are allowed to use the application. The system will then request access permissions such as location access. If the user presses X, the application will still function normally. However, when a feature that requires permission is used, the system will request the permission again.'
          },
          {
            'title': '3. Start CPR',
            'body':
                'When the user selects the Start menu, a window will appear asking the user to select the patient\'s age group. Users may also select the Emergency Call checkbox, which will automatically contact the nearest hospital. After pressing Next Step, the system will display concise instructions and information. When the user presses Start CPR, the application will navigate to the assistance screen. This screen includes a cycle timer, a display showing the selected patient type, a counter showing the number of completed cycles, which increases until the required number of cycles is reached. Once completed, the system will send a signal. The screen also includes a status display and a button to stop CPR.'
          },
          {
            'title': '4. Quick Guide',
            'body':
                'When the user selects the Quick Guide menu, the system will display steps related to assisting and observing patients who may require CPR. Users can scroll down to view additional information. When a user selects a patient\'s symptom, the system will automatically navigate to the relevant page within 5 seconds. This page displays the patient\'s symptoms and the user\'s current location. Users can press Emergency Call to contact the hospital. On the final page, there will be a Start CPR option if the user wishes to perform CPR themselves.'
          },
          {
            'title': '5. Emergency Call',
            'body':
                'When the user selects the Emergency Call menu, the system will display a page containing information about important emergency service units in Thailand. An Emergency Call button will also be available to contact a hospital.'
          },
          {
            'title': '6. Find Hospital',
            'body':
                'When the user selects the Find Hospital menu, the system will display a page with a search field where users can search for a hospital by name. If no text is entered, the system will display the nearest hospitals by default. When the user selects a hospital, the system will show a map with navigation between the user\'s location and the selected hospital. Users can zoom in or out on the map.'
          },
          {
            'title': '7. Quick Test',
            'body':
                'When the user selects the Quick Test menu, the system will display a quiz page. If the user answers correctly, the correct answer will be highlighted and an explanation will be displayed. If the user answers incorrectly, the system will display the correct answer and highlight the correct option in green and the incorrect option in red, along with an explanation of the correct answer. Users can press Next to proceed to the next question and Previous to return to the previous question.'
          },
          {
            'title': '8. Tutorials Menu',
            'body':
                'When the user selects the Tutorials menu, the system will display instructions on how to use the application and provide basic CPR knowledge. At the final step, users can press a button to navigate to the main page. Users may also press Skip to jump directly to the last step.'
          },
          {
            'title': '9. Settings',
            'body':
                'When the user presses the gear icon in the top-right corner, the system will navigate to the Settings page. The available options include Notifications, Configuration, Privacy, Language, Help, Terms and Conditions of Service, Privacy Policy, and Medical References.'
          }
        ]
      }
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
          'title': 'เริ่มทำ CPR',
          'desc':
              'คู่มือแนะนำการทำ CPR แบบโต้ตอบเพื่อช่วยเหลือคุณในยามฉุกเฉิน มีเสียงและจังหวะเพื่อรักษาจังหวะที่ถูกต้อง',
          'feat1': 'เลือกอายุ',
          'feat2': 'ให้จังหวะ',
          'feat3': 'จับเวลา',
        },
        {
          'title': 'คู่มือด่วน',
          'desc':
              'คำแนะนำที่ทำตามได้ง่ายและรวดเร็ว สำหรับตรวจสอบสถานที่ ประเมินผู้ป่วย และดูอาการก่อนลงมือ',
          'feat1': 'ตรวจสถานที่',
          'feat2': 'ตอบสนอง',
          'feat3': 'ดูอาการ',
        },
        {
          'title': 'โทรฉุกเฉิน',
          'desc':
              'เข้าถึงบริการช่วยเหลือฉุกเฉินระดับมืออาชีพอย่างรวดเร็ว โทรหาเบอร์ฉุกเฉินแต่ละแห่งในพื้นที่ได้ด้วยสัมผัสเดียว',
          'feat1': 'โทรด่วน',
          'feat2': 'เบอร์ท้องถิ่น',
          'feat3': 'ตำแหน่ง',
        },
        {
          'title': 'แบบทดสอบ',
          'desc':
              'ทดสอบความรู้ของคุณด้วยสถานการณ์สมมติ เพื่อให้แน่ใจว่าคุณพร้อมเมื่อถึงเวลาที่สำคัญที่สุด',
          'feat1': 'คำถาม',
          'feat2': 'จำลองเหตุ',
          'feat3': 'ผลสอบ',
        },
        {
          'title': 'ทำต่อไปจนกว่าความช่วยเหลือจะมาถึง',
          'desc':
              'ทำ CPR ต่อไปจนกว่าทีมกู้ชีพจะมาถึง มีเครื่อง AED พร้อมใช้งาน หรือผู้ป่วยมีการตอบสนอง',
          'image': 'assets/images/people_in_med.png',
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
        'terms': 'ข้อกำหนดและเงื่อนไขการใช้บริการ',
        'privacy_pol': 'นโยบายความเป็นส่วนตัว',
        'medical_ref': 'อ้างอิงทางการแพทย์',
        'select_lang': 'เลือกภาษา',
        'display_sec': 'การกำหนดค่า',
        'dark_mode': 'โหมดมืด',
        'text_size': 'ขนาดตัวอักษร',
        'loc_permission': 'การอนุญาตตำแหน่ง',
        'loc_permission_desc':
            'อนุญาตให้แอปเข้าถึงตำแหน่งของคุณเพื่อค้นหาโรงพยาบาลใกล้เคียง',
        'accept_terms': 'ข้อกำหนดและเงื่อนไข',
        'accept_terms_desc': 'จำเป็นต้องยอมรับข้อกำหนดเพื่อใช้งานแอปพลิเคชัน',
        'revoke_title': 'ยกเลิกข้อตกลง?',
        'revoke_desc':
            'หากคุณยกเลิกการยอมรับข้อกำหนดและเงื่อนไข แอปจะปิดตัวลงและคุณจะต้องยอมรับอีกครั้งเพื่อใช้งานแอปพลิเคชัน',
        'cancel': 'ยกเลิก',
        'revoke_btn': 'ยกเลิกและปิดแอป',
        'loc_required': 'จำเป็นต้องได้รับอนุญาตตำแหน่ง',
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
      'quick_guide_age_select': {
        'title': 'เลือกระบุช่วงอายุผู้ป่วย',
        'desc': 'เลือกช่วงอายุด้านล่างเพื่อดูขั้นตอน CPR ที่เหมาะสม',
        'adult': 'ผู้ใหญ่ (มากกว่า 8 ปี)',
        'infant_child': 'เด็กและทารก (น้อยกว่า 8 ปี)',
        'selected_prefix': 'ช่วงอายุ:',
        'change': 'เปลี่ยนช่วงอายุ',
      },
      'quick_guide_adult_cpr': [
        {
          'number': '5',
          'title': 'เปิดทางเดินหายใจ',
          'description': 'เชิดคางขึ้นเพื่อให้ศีรษะแหงนไปด้านหลังเล็กน้อย',
        },
        {
          'number': '6',
          'title': 'วัดการหายใจ',
          'description': 'ฟังประมาณ 10 วินาที หากไม่หายใจให้เริ่ม CPR ทันที',
        },
        {
          'number': '7',
          'title': 'กดหน้าอก 30 ครั้ง',
          'description':
              'กดแรงและเร็ว (ลึก 2 นิ้ว, 100-120 ครั้ง/นาที) ที่บริเวณตรงกลางหน้าอก',
        },
        {
          'number': '8',
          'title': 'เป่าปาก 2 ครั้ง',
          'description':
              'บีบจมูกผู้ป่วยให้แน่น ครอบปากให้สนิท แล้วเป่าลมหร้อมมองดูหน้าอกว่าขยับขึ้นหรือไม่',
        },
        {
          'number': '9',
          'title': 'ทำซ้ำ',
          'description':
              'ทำซ้ำรอบการกดหน้าอก 30 ครั้ง และเป่าปาก 2 ครั้ง จนกว่าความช่วยเหลือจะมาถึง',
        },
      ],
      'quick_guide_child_cpr': [
        {
          'number': '5',
          'title': 'เปิดทางเดินหายใจ',
          'description': 'เชิดคางขึ้นเพื่อให้ศีรษะแหงนไปด้านหลังเล็กน้อย',
        },
        {
          'number': '6',
          'title': 'วัดการหายใจ',
          'description': 'ฟังประมาณ 10 วินาที หากไม่หายใจให้เริ่ม CPR ทันที',
        },
        {
          'number': '7',
          'title': 'เป่าปาก 2 ครั้ง',
          'description':
              'เด็ก: บีบจมูกแล้วเป่าเข้าปาก 2 ครั้ง\nทารก: ครอบจมูกและปากแล้วเป่า 2 ครั้ง',
        },
        {
          'number': '8',
          'title': 'กดหน้าอก 30 ครั้ง',
          'description':
              'เด็ก: ใช้สันมือ 1 ข้าง กดลึกประมาณ 2 นิ้ว\nทารก: ใช้ 2 นิ้ว กดลึกประมาณ 1.5 นิ้ว',
        },
        {
          'number': '9',
          'title': 'ทำซ้ำ',
          'description':
              'ทำซ้ำรอบการกดหน้าอก 30 ครั้ง และเป่าปาก 2 ครั้ง จนกว่าความช่วยเหลือจะมาถึง',
        },
      ],
      'emergency_call': {
        'title': 'โทรฉุกเฉิน',
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
        'return_reminder': 'หลังจากกดโทรฉุกเฉินแล้วอย่าลืมกลับเข้าแอพด้วยนะ',
      },
      'cpr': {
        'cpr_title': 'CPR',
        // Select Age
        'select_age_title': 'ช่วงอายุของผู้ป่วย',
        'infant': 'ทารก',
        'infant_sub': 'อายุต่ำกว่า 1 ปี',
        'child': 'เด็ก',
        'child_sub': 'อายุ 1-8 ปี',
        'adult': 'ผู้ใหญ่',
        'adult_sub': 'อายุมากกว่า 8 ปี',
        'emergency_call': 'โทรฉุกเฉิน',
        'next_step': 'ขั้นตอนถัดไป',
        // Prep Guide
        'remember': 'ข้อมูลเบื้องต้น',
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
        'success_title': 'ผลลัพธ์',
        'success': 'สำเร็จ!',
        'speed': 'ความเร็ว',
        'age': 'อายุ',
        'time': 'เวลา',
        'full_cycles': 'รอบสมบูรณ์',
        'done': 'เสร็จสิ้น',
      },
      'find_hospital_sec': {
        'title': 'ค้นหาโรงพยาบาล',
        'search': 'ค้นหา',
        'search_hint': 'ค้นหาโรงพยาบาล',
        'near_me': 'โรงพยาบาลใกล้ฉัน >',
        'select_dest': 'เลือกจุดหมายปลายทาง',
        'your_position': 'ตำแหน่งของคุณ',
        'scroll_down': 'เลื่อนลงเพื่อไปยังหน้าหลัก',
        'loc_fetching': 'กำลังค้นหาตำแหน่งของคุณ...',
        'hosp_fetching': 'กำลังค้นหาโรงพยาบาลใกล้เคียง...',
        'no_hosp': 'ไม่พบโรงพยาบาลในรัศมี (10กม.)',
        'loc_denied': 'ไม่ได้รับอนุญาตให้เข้าถึงตำแหน่ง',
        'open_map': 'เปิดแผนที่',
        'km': 'กม.',
        'loc_permission_title': 'ต้องการเข้าถึงพิกัดของคุณ',
        'loc_permission_desc':
            'แอปจำเป็นต้องใช้สัญญาณ GPS เพื่อค้นหาและแสดงรายการโรงพยาบาลที่อยู่ใกล้คุณที่สุดในขณะนี้',
        'loc_permission_btn': 'อนุญาต / เปิดใช้งาน GPS',
        'try_again': 'ลองใหม่อีกครั้ง',
        'app_settings_needed':
            'กรุณาอนุญาตการเข้าถึงตำแหน่งในหน้าการตั้งค่าของมือถือ',
        'no_coordinates': 'ไม่สามารถระบุพิกัดได้\nกรุณาลองใหม่ในที่โล่ง',
        'server_error': 'เซิร์ฟเวอร์ตอบกลับผิดพลาด กรุณาลองใหม่',
        'connection_error': 'เกิดข้อผิดพลาดในการเชื่อมต่ออินเทอร์เน็ต',
      },
      'cpr_conditions': {
        'title_when_cpr': 'อาการของผู้ป่วย',
        'instruction': 'กดปุ่มหากพบอาการ',
        'cardiac_arrest': 'หัวใจหยุดเต้น',
        'unconsciousness': 'หมดสติ',
        'choking': 'สำลัก',
        'severe_trauma': 'บาดเจ็บสาหัส',
        'drug_overdose': 'ใช้ยาเกินขนาด',
        'drowning': 'จมน้ำ',
        'electric_shock': 'ไฟฟ้าช็อต',
        'not_breathing': 'หยุดหายใจ',
        'severe_allergic_reaction': 'อาการแพ้อย่างรุนแรง',
        'toxic_gas_smoke': 'ก๊าซพิษหรือควัน',
      },
      'cpr_required': {
        'title': 'ต้องการทำ CPR',
        'follow_steps': 'ให้ทำตามขั้นตอน',
        'symptoms': 'มีอาการ:',
        'press_button': 'ให้กดปุ่ม แล้วกลับเข้าแอพ',
      },
      'cpr_perform_rules': {
        'title': 'เมื่อใดควรทำ CPR?',
        'desc':
            'CPR เป็นเทคนิคช่วยชีวิตในยามฉุกเฉินเมื่อผู้ป่วยหยุดหายใจหรือหัวใจหยุดเต้น',
        'list_items': [
          {
            'title': '1. หัวใจหยุดเต้น (Cardiac Arrest)',
            'desc':
                'หัวใจหยุดเต้นกะทันหัน การทำ CPR ทันทีช่วยรักษากระแสเลือดไปยังสมองและอวัยวะสำคัญ'
          },
          {
            'title': '2. หมดสติ (Unconsciousness)',
            'desc': 'เมื่อบุคคลไม่ตอบสนองและไม่สามารถหายใจได้ตามปกติ'
          },
          {
            'title': '3. การสำลัก (Choking)',
            'desc':
                'ทางเดินหายใจถูกอุดกั้นจนหยุดหายใจ หรือเกิดจากอุบัติเหตุรุนแรง'
          },
          {
            'title': '4. การบาดเจ็บสาหัส (Severe Trauma)',
            'desc': 'การบาดเจ็บรุนแรงที่รบกวนจังหวะการเต้นของหัวใจหรือทำลายปอด'
          },
          {
            'title': '5. การใช้ยาเกินขนาด (Drug Overdose)',
            'desc': 'ร่างกายรับสารเกินขนาดทำให้การหายใจช้าลงหรือหยุดหายใจ'
          },
          {
            'title': '6. การจมน้ำ (Drowning)',
            'desc':
                'อาจหยุดหายใจเพราะน้ำเข้าไปในปอด ระวังภาวะแทรกซ้อนจากการจมน้ำ'
          },
          {
            'title': '7. ไฟฟ้าช็อต (Electric Shock)',
            'desc':
                'กระแสไฟฟ้าขัดขวางสัญญาณหัวใจ การทำ CPR ช่วยรักษาการไหลเวียนของเลือด'
          },
        ]
      },
      'cpr_not_perform_rules': {
        'title': 'เมื่อใดที่ไม่ควรทำ CPR?',
        'desc':
            'หากผู้ป่วยยังมีสติและหายใจได้ ไม่จำเป็นต้องทำ CPR และมีสถานการณ์ที่ห้ามทำดังนี้:',
        'list_items': [
          {
            'title': '1. มีสัญญาณการเสียชีวิตชัดเจน',
            'desc':
                'เช่น ร่างกายแข็งเกร็งหรือบาดเจ็บสาหัสมากจนชัดเจนว่าไม่สามารถกู้ชีพได้'
          },
          {
            'title': '2. คำสั่งห้ามกู้ชีพ (DNR Orders)',
            'desc':
                'เอกสารทางกฎหมายที่ระบุความประสงค์ของผู้ป่วยในการงดเว้นการทำ CPR'
          },
          {
            'title': '3. สภาพแวดล้อมไม่ปลอดภัย',
            'desc':
                'สถานที่ที่มีอันตรายเช่น ไฟไหม้ สารพิษ ควรคำนึงถึงความปลอดภัยก่อนเสมอ'
          },
          {
            'title': '4. ภาวะทางการแพทย์ระยะสุดท้าย',
            'desc':
                'ผู้ป่วยระยะสุดท้ายหรือการดูแลแบบประคับประคองที่เน้นความสบาย'
          },
          {
            'title': '5. การประเมินจากผู้เชี่ยวชาญ',
            'desc': 'เมื่อบุคลากรทางการแพทย์ประเมินว่าการทำ CPR จะไม่ได้ผล'
          },
        ]
      },
      'how_to_cpr_screen': {
        'adult_cpr': 'การทำ CPR สำหรับผู้ใหญ่',
        'adult_step1_title': 'ขั้นตอนที่ 1. โทร 1669',
        'adult_step1_desc':
            'ก่อนอื่นให้สำรวจสถานที่ว่ามีอันตรายหรือไม่ เช่น รถวิ่ง ไฟไหม้ หรือของร่วงหล่น จากนั้นประเมินผู้ป่วยโดยตบไหล่และตะโกนถามว่า "คุณโอเคไหม?"\n\nหากไม่ตอบสนอง ให้โทร 1669 หรือขอให้คนอื่นช่วยโทรเรียกก่อนทำ CPR หากเป็นไปได้ให้คนอื่นไปหาเครื่อง AED ซึ่งมักจะอยู่ในอาคารสาธารณะ',
        'adult_step2_title': 'ขั้นตอนที่ 2. จัดให้นอนหงายและเปิดทางเดินหายใจ',
        'adult_step2_desc':
            'จัดให้ผู้ป่วยนอนหงายอย่างระมัดระวังและคุกเข่าข้างหน้าอก เชิดคางและดันหน้าผากเพื่อให้ศีรษะแหงนไปด้านหลังเล็กน้อย\n\nเปิดปากและตรวจดูสิ่งกีดขวาง เช่น อาหารหรืออาเจียน ถ้านำออกได้ง่ายให้เอาออก แต่อย่าพยายามล้วงถ้ามันลึกเกินไปเพราะอาจดันเข้าไปลึกกว่าเดิม',
        'adult_step3_title': 'ขั้นตอนที่ 3. ตรวจการหายใจ',
        'adult_step3_desc':
            'แนบหูใกล้ปากผู้ป่วยและฟังเสียงหายใจไม่เกิน 10 วินาที หากไม่ได้ยินเสียงหายใจหรือหายใจเฮือก ให้เริ่มทำ CPR\n\nหากผู้ป่วยหมดสติแต่ยังหายใจได้อยู่ ไม่ต้องทำ CPR ให้จัดท่าพักฟื้น (Recovery position) หากไม่สงสัยว่ามีการบาดเจ็บที่กระดูกสันหลัง ติดตามการหายใจและทำ CPR หากหยุดหายใจ',
        'cpr_steps_title': 'ขั้นตอนการทำ CPR',
        'adult_step4_title': 'ขั้นตอนที่ 4. กดหน้าอก 30 ครั้ง',
        'adult_step4_desc':
            'วางสันมือข้างหนึ่งไว้ตรงกลางหน้าอก (กึ่งกลางระหว่างหัวนม) แล้วนำมืออีกข้างมาประสานทับ แขนตึง ดันลงไปแรงๆ และเร็วๆ\n\nกดลึกอย่างน้อย 2 นิ้ว (5 ซม.) ด้วยความเร็ว 100-120 ครั้งต่อนาที ปล่อยให้หน้าอกคืนตัวเต็มที่ก่อนกดครั้งต่อไป',
        'adult_step5_title': 'ขั้นตอนที่ 5. เป่าปาก 2 ครั้ง',
        'adult_step5_desc':
            'ตรวจสอบให้แน่ใจว่าในปากไม่มีสิ่งกีดขวาง เชิดคางขึ้น บีบจมูกผู้ป่วยให้แน่น ครอบปากให้สนิท แล้วเป่าลมหร้อมมองดูหน้าอกว่าขยับขึ้นหรือไม่\n\nหากหน้าอกไม่ยกลงในการเป่าครั้งแรก ให้จัดองศาการเชิดคางใหม่ หากครั้งที่สองยังไม่ยกขึ้น ผู้ป่วยอาจมีอาการสำลักอุดกั้นทางเดินหายใจ',
        'adult_step6_title': 'ขั้นตอนที่ 6. ทำซ้ำ',
        'adult_step6_desc':
            'ทำซ้ำรอบการกดหน้าอก 30 ครั้ง และเป่าปาก 2 ครั้ง จนกว่าผู้ป่วยจะเริ่มหายใจ หรือความช่วยเหลือมาถึง หากเครื่อง AED มาถึง ให้ทำ CPR ต่อไปจนกว่าจะติดตั้งเครื่องเสร็จและพร้อมใช้งาน',
        'child_cpr_title': 'การทำ CPR สำหรับเด็กและทารก: ทีละขั้นตอน',
        'child_cpr_desc':
            'ขั้นตอนการทำ CPR สำหรับเด็กและทารกแตกต่างจากผู้ใหญ่เล็กน้อย ดังนี้',
        'child_bullet1': 'สำหรับเด็ก: ตบไหล่และตะโกนถามว่า "คุณโอเคไหม?"',
        'child_bullet2': 'สำหรับทารก: ดีดที่ฝ่าเท้าเพื่อดูการตอบสนอง',
        'child_step1_title': 'ขั้นตอนที่ 1. โทร 1669 หรือดูแลเบื้องต้น 2 นาที',
        'child_step1_desc':
            'หากคุณอยู่คนเดียวและเด็ก/ทารกไม่ตอบสนอง ให้ปฐมพยาบาลเบื้องต้น 2 นาทีก่อนโทร 1669 หากมีคนอื่นอยู่ด้วย ให้พวกเขาโทร 1669 ทันทีในขณะที่คุณปฐมพยาบาล\n\nหากเด็กตอบสนอง ให้โทร 1669 เพื่อรายงานอาการที่อาจเป็นอันตรายถึงชีวิต',
        'child_step2_title': 'ขั้นตอนที่ 2. จัดนอนหงายและเปิดทางเดินหายใจ',
        'child_step2_desc':
            'จัดให้เด็กหรือทารกนอนหงายและคุกเข่าข้างหน้าอก เชิดคางขึ้นเพื่อแหงนศีรษะไปด้านหลังเล็กน้อย\n\nตรวจดูสิ่งกีดขวาง ถ้านำออกได้ง่ายให้ดึงออก แต่อย่าล้วงหากเข้าไปลึกแล้ว',
        'child_step3_title': 'ขั้นตอนที่ 3. ตรวจการหายใจ',
        'child_step3_desc':
            'ฟังเสียงหายใจประมาณ 10 วินาที รูปแบบการหายใจของทารกอาจเปลี่ยนแปลงได้ซึ่งเป็นเรื่องปกติ\n\nติดตามการหายใจต่อไปและเริ่มทำ CPR หากหยุดหายใจ',
        'child_step4_title': 'ขั้นตอนที่ 4. เป่าปาก 2 ครั้ง',
        'child_step4_desc':
            'หากไม่หายใจ ให้เป่าลม 2 ครั้ง\n\n• สำหรับเด็ก: บีบจมูกและครอบปากเป่าลมเข้า 2 ครั้ง\n• สำหรับทารก: ครอบปากของคุณที่ปากและจมูกของทารก เป่าลม 1 วินาทีให้หน้าอกยกตัว ทำ 2 ครั้ง',
        'child_step5_title': 'ขั้นตอนที่ 5. กดหน้าอก 30 ครั้ง',
        'child_step5_desc':
            'คุกเข่าข้างทารกหรือเด็ก\n\n• สำหรับเด็ก: ใช้มือเดียว วางสันมือที่กึ่งกลางหน้าอก กดให้ลึกประมาณ 2 นิ้ว อย่างน้อย 100 ครั้งต่อนาที\n• สำหรับทารก: ใช้ 2 นิ้ว วางที่กึ่งกลางหน้าอก กด 30 ครั้งอย่างรวดเร็ว ลึกประมาณ 1.5 นิ้ว',
        'child_step6_title': 'ขั้นตอนที่ 6. ทำซ้ำ',
        'child_step6_desc':
            'ทำซ้ำรอบการเป่าปากและกดหน้าอก จนกว่าเด็กจะเริ่มหายใจหรือความช่วยเหลือมาถึง',
      },
      'quick_test_screen': {
        'title': 'แบบทดสอบ',
        'next': 'ถัดไป',
        'previous': 'ก่อนหน้า',
        'finish': 'เสร็จสิ้น',
        'explanation': 'คำอธิบาย:',
        'correct': 'ถูกต้อง!',
        'incorrect': 'ไม่ถูกต้อง!',
        'result_title': 'ผลการทดสอบ',
        'score': 'คะแนนของคุณ:',
        'try_again': 'ลองอีกครั้ง',
      },
      'quick_test_questions': [
        {
          'question':
              'อัตราส่วนการกดหน้าอกต่อการช่วยหายใจที่ถูกต้องสำหรับผู้ใหญ่เมื่อมีผู้ช่วยเหลือสองคนคือเท่าใด?',
          'options': ['15:2', '30:2', '20:1', '10:2'],
          'answerIndex': 1,
          'explanation':
              'สำหรับการทำ CPR ในผู้ใหญ่ที่มีผู้ช่วยเหลือสองคน อัตราส่วนคือการกดหน้าอก 30 ครั้งต่อการช่วยหายใจ 2 ครั้ง เพื่อให้มีการไหลเวียนของเลือดและออกซิเจนอย่างมีประสิทธิภาพ'
        },
        {
          'question': 'ในสถานการณ์ใดควรเริ่มทำ CPR ทันทีโดยไม่ต้องตรวจหาชีพจร?',
          'options': [
            'ผู้ใหญ่ที่มีสติและมีอาการเจ็บหน้าอก',
            'ผู้ใหญ่ที่ไม่ตอบสนองและไม่หายใจตามปกติ',
            'เด็กที่มีอาการบาดเจ็บเล็กน้อย',
            'ทารกที่กำลังร้องไห้'
          ],
          'answerIndex': 1,
          'explanation':
              'หากผู้ใหญ่ไม่ตอบสนองและไม่หายใจตามปกติ ให้เริ่มทำ CPR ทันที เนื่องจากการล่าช้าจะลดโอกาสในการรอดชีวิต'
        },
        {
          'question':
              'ความลึกที่แนะนำสำหรับการกดหน้าอกในผู้ใหญ่ขณะทำ CPR คือเท่าใด?',
          'options': [
            'อย่างน้อย 2 นิ้ว (5 ซม.)',
            'อย่างน้อย 1 นิ้ว (2.5 ซม.)',
            'อย่างน้อย 3 นิ้ว (7.5 ซม.)',
            'อย่างน้อย 4 นิ้ว (10 ซม.)'
          ],
          'answerIndex': 0,
          'explanation':
              'ควรกดหน้าอกให้ลึกอย่างน้อย 2 นิ้ว เพื่อปั๊มเลือดผ่านหัวใจไปยังร่างกายได้อย่างมีประสิทธิภาพ'
        },
        {
          'question': 'คุณควรวางมืออย่างไรเพื่อกดหน้าอกในผู้ใหญ่?',
          'options': [
            'ครึ่งล่างของกระดูกหน้าอก',
            'บนหน้าท้องส่วนบน',
            'ที่ด้านข้างของหน้าอก',
            'ที่คอ'
          ],
          'answerIndex': 0,
          'explanation':
              'วางสันมือข้างหนึ่งไว้ตรงกลางหน้าอก บริเวณครึ่งล่างของกระดูกหน้าอก เพื่อให้การกดหน้าอกมีประสิทธิภาพ'
        },
        {
          'question': 'จุดประสงค์หลักของการกดหน้าอกในการทำ CPR คืออะไร?',
          'options': [
            'เพื่อให้ได้รับออกซิเจนเข้าสู่ปอด',
            'เพื่อรักษาการไหลเวียนของเลือดไปยังอวัยวะสำคัญ',
            'เพื่อกำจัดสิ่งอุดกั้นทางเดินหายใจ',
            'เพื่อตรวจวัดจังหวะการเต้นของหัวใจ'
          ],
          'answerIndex': 1,
          'explanation':
              'การกดหน้าอกช่วยปั๊มเลือดจากหัวใจไปยังสมองและอวัยวะอื่น ๆ เพื่อประทังชีวิตจนกว่าความช่วยเหลือขั้นสูงจะมาถึง'
        },
        {
          'question': 'เมื่อทำ CPR ในทารก อัตราการกดหน้าอกที่ถูกต้องคือเท่าใด?',
          'options': [
            '100-120 ครั้งต่อนาที',
            '60-80 ครั้งต่อนาที',
            '80-100 ครั้งต่อนาที',
            '120-140 ครั้งต่อนาที'
          ],
          'answerIndex': 0,
          'explanation':
              'อัตราการกดหน้าอกสำหรับทารกจะเท่ากับผู้ใหญ่และเด็ก คือ 100-120 ครั้งต่อนาที เพื่อให้การไหลเวียนของเลือดมีประสิทธิภาพ'
        },
        {
          'question': 'คุณควรทำอย่างไรหากทางเดินหายใจอุดกั้นระหว่างการทำ CPR?',
          'options': [
            'กดหน้าท้อง',
            'ตบหลัง',
            'ใช้เทคนิคเชยคางดันหน้าผาก',
            'กดหน้าอกต่อไปโดยไม่หยุดพัก'
          ],
          'answerIndex': 2,
          'explanation':
              'เทคนิคเชยคางดันหน้าผากช่วยเปิดทางเดินหายใจ หากยังอุดกั้นอยู่ ให้ประเมินใหม่และดำเนินการตามขั้นตอน CPR ต่อไป'
        },
        {
          'question':
              'คุณควรตรวจการหายใจในผู้ที่ไม่ตอบสนองนานแค่ไหนก่อนเริ่มทำ CPR?',
          'options': [
            'ไม่เกิน 10 วินาที',
            'ไม่เกิน 1 นาที',
            'ไม่เกิน 30 วินาที',
            'ไม่เกิน 5 วินาที'
          ],
          'answerIndex': 0,
          'explanation':
              'ตรวจการหายใจไม่เกิน 10 วินาที เพื่อรีบตัดสินใจว่าจำเป็นต้องทำ CPR หรือไม่ และเพื่อหลีกเลี่ยงความล่าช้าที่ไม่จำเป็น'
        },
        {
          'question': 'ลำดับขั้นตอน CPR ที่ถูกต้องสำหรับผู้ใหญ่คืออะไร?',
          'options': [
            'เปิดทางเดินหายใจ, ช่วยหายใจ, กดหน้าอก',
            'กดหน้าอก, เปิดทางเดินหายใจ, ช่วยหายใจ',
            'ช่วยหายใจ, กดหน้าอก, เปิดทางเดินหายใจ',
            'กดหน้าอก, เปิดทางเดินหายใจ, ใช้เครื่อง AED'
          ],
          'answerIndex': 1,
          'explanation':
              'ลำดับ C-A-B (Compressions, Airway, Breathing) ให้ความสำคัญกับการไหลเวียนเลือดเป็นอันดับแรกเพื่อป้องกันสมองขาดออกซิเจน'
        },
        {
          'question':
              'เมื่อใช้เครื่อง AED กับเด็ก หากไม่มีแผ่นแปะสำหรับเด็กคุณควรทำอย่างไร?',
          'options': [
            'ไม่ต้องใช้เครื่อง AED',
            'ใช้แผ่นแปะสำหรับผู้ใหญ่หากแผ่นไม่สัมผัสกัน',
            'รอคนมาช่วย',
            'ใช้แผ่นแปะที่หลัง'
          ],
          'answerIndex': 1,
          'explanation':
              'หากไม่มีแผ่นแปะสำหรับเด็ก สามารถใช้แผ่นแปะสำหรับผู้ใหญ่กับเด็กได้ตราบเท่าที่แผ่นไม่ซ้อนทับกัน เพื่อส่งกระแสไฟฟ้าได้อย่างปลอดภัย'
        },
        {
          'question':
              'ปริมาณการช่วยหายใจที่แนะนำสำหรับผู้ใหญ่ขณะทำ CPR คือเท่าใด?',
          'options': [
            'ลมหายใจเต็มปอดของคุณ',
            'แค่พอให้หน้าอกยกตัวขึ้น',
            'เป่าลมแรงๆ สองครั้งติดกัน',
            'ไม่ต้องช่วยหายใจ ให้กดหน้าอกอย่างเดียว'
          ],
          'answerIndex': 1,
          'explanation':
              'ช่วยหายใจเพียงเพื่อให้หน้าอกยกตัวขึ้น ปกติประมาณ 500-600 มล. เพื่อหลีกเลี่ยงการเป่าลมมากเกินไปจนเข้าสู่กระเพาะอาหาร'
        },
        {
          'question':
              'ทำไมการปล่อยให้หน้าอกคืนตัวเต็มที่ระหว่างการกดหน้าอกจึงสำคัญ?',
          'options': [
            'เพื่อให้ผู้ช่วยเหลือได้พัก',
            'เพื่อให้เลือดไหลกลับเข้าสู่หัวใจ',
            'เพื่อตรวจการหายใจ',
            'เพื่อปรับตำแหน่งมือ'
          ],
          'answerIndex': 1,
          'explanation':
              'การคืนตัวเต็มที่ช่วยให้หัวใจมีเลือดเต็มห้องระหว่างการกดแต่ละครั้ง ซึ่งจะช่วยเพิ่มปริมาณการไหลเวียนเลือดและประสิทธิภาพของการทำ CPR'
        },
        {
          'question':
              'คุณควรทำ CPR ต่อไปนานแค่ไหนจนกว่าความช่วยเหลือจะมาถึงหรือผู้ป่วยมีสัญญาณชีพ?',
          'options': [
            'จนกว่าคุณจะเหนื่อย',
            'นาน 5 นาที',
            'จนกว่าหน่วยกู้ชีพจะมารับช่วงต่อ',
            'นาน 10 นาที'
          ],
          'answerIndex': 2,
          'explanation':
              'ทำ CPR ต่อไปจนกว่าความช่วยเหลือทางการแพทย์ขั้นสูงจะมาถึง ผู้ป่วยฟื้นตัว หรือมีผู้ช่วยเหลือคนอื่นมาสลับ'
        },
        {
          'question':
              'ความแตกต่างที่สำคัญในการทำ CPR สำหรับเด็กเทียบกับผู้ใหญ่คืออะไร?',
          'options': [
            'ใช้มือเพียงข้างเดียวในการกดหน้าอก',
            'ตรวจชีพจรนานสูงสุด 60 วินาที',
            'ความลึกในการกดหน้าอกจะตื้นกว่า',
            'ไม่ต้องใช้เครื่อง AED'
          ],
          'answerIndex': 2,
          'explanation':
              'สำหรับเด็ก ควรรกดหน้าอกให้ลึกประมาณหนึ่งในสามของความหนาหน้าอก ปกติคือ 2 นิ้วสำหรับเด็กโต เพื่อหลีกเลี่ยงการบาดเจ็บ'
        },
        {
          'question': 'คุณควรทำอย่างไรหากอยู่คนเดียวและพบผู้ใหญ่ที่ไม่ตอบสนอง?',
          'options': [
            'เริ่มทำ CPR ทันที',
            'โทรเรียกความช่วยเหลือก่อนแล้วค่อยเริ่มทำ CPR',
            'รอให้มีคนอื่นมาเห็น',
            'ตรวจดูว่ามีอาการแพ้หรือไม่'
          ],
          'answerIndex': 1,
          'explanation':
              'หากอยู่คนเดียว ให้โทรแจ้งเหตุฉุกเฉินหรือนำเครื่อง AED มาก่อน แล้วจึงเริ่มทำ CPR เพื่อให้มั่นใจว่าความช่วยเหลืออยู่ระหว่างการเดินทาง'
        },
        {
          'question':
              'ระหว่างการทำ CPR โดยผู้ช่วยเหลือสองคน ควรเปลี่ยนบทบาทกันบ่อยแค่ไหน?',
          'options': [
            'ทุก 2 นาที',
            'ทุก 5 นาที',
            'ทุก 1 นาที',
            'ไม่ต้องเปลี่ยนบทบาท'
          ],
          'answerIndex': 0,
          'explanation':
              'การเปลี่ยนบทบาททุก 2 นาทีช่วยรักษคุณภาพการกดหน้าอกให้คงที่โดยป้องกันความเหนื่อยล้าของผู้ช่วยเหลือ'
        },
        {
          'question':
              'สิ่งแรกที่ต้องทำเมื่อไปถึงที่เกิดเหตุและพบผู้ที่ไม่ตอบสนองคืออะไร?',
          'options': [
            'เริ่มกดหน้าอก',
            'ตรวจสอบความปลอดภัยของสถานที่',
            'ช่วยหายใจ',
            'ใช้เครื่อง AED'
          ],
          'answerIndex': 1,
          'explanation':
              'ตรวจสอบความปลอดภัยของสถานที่ก่อนเสมอเพื่อป้องกันตัวเองและหลีกเลี่ยงความเสี่ยงเพิ่มเติม'
        },
        {
          'question': 'ในการทำ CPR ตัวอักษร "A" ในลำดับ C-A-B ย่อมาจากอะไร?',
          'options': [
            'การประเมิน (Assessment)',
            'ทางเดินหายใจ (Airway)',
            'การช่วยเหลือ (Assistance)',
            'AED'
          ],
          'answerIndex': 1,
          'explanation':
              " 'A' ย่อมาจาก Airway (ทางเดินหายใจ) ซึ่งหมายถึงการเปิดทางเดินหายใจเพื่อให้ช่วยหายใจได้อย่างมีประสิทธิภาพ"
        },
        {
          'question': 'ทำไมจึงไม่ควรขัดจังหวะการกดหน้าอกระหว่างการทำ CPR?',
          'options': [
            'เพื่อให้รักษจังหวะให้คงที่',
            'เพื่อให้มีช่วงเวลาพัก',
            'เพื่อลดการหยุดชะงักของการไหลเวียนเลือด',
            'เพื่อตรวจหาชีพจร'
          ],
          'answerIndex': 2,
          'explanation':
              'การขัดจังหวะจะลดการไหลเวียนเลือดไปยังอวัยวะสำคัญ ดังนั้นควรตั้งเป้าที่จะหยุดพักให้น้อยที่สุดเพื่อเพิ่มอัตราการรอดชีวิต'
        },
        {
          'question': 'การวางมือที่ถูกต้องสำหรับการทำ CPR ในทารกคืออะไร?',
          'options': [
            'ใช้สองนิ้ววางตรงกลางหน้าอก',
            'ใช้ทั้งสองมือวางที่หน้าท้อง',
            'ใช้มือข้างเดียววางบนหน้าอก',
            'วางนิ้วที่ด้านข้าง'
          ],
          'answerIndex': 0,
          'explanation':
              'สำหรับทารก ให้ใช้สองนิ้ว (นิ้วชี้และนิ้วกลาง) วางตรงกลางหน้าอก ใต้แนวหัวนมเล็กน้อย เพื่อการกดหน้าอกที่มีประสิทธิภาพโดยไม่ทำให้เกิดการบาดเจ็บ'
        },
      ],
      'terms_page': {
        'title': 'ข้อกำหนดและเงื่อนไขการใช้บริการ',
        'last_updated': 'แก้ไขล่าสุด: มีนาคม 2569',
        'sections': [
          {
            'title': '1. การยอมรับข้อกำหนด',
            'body':
                'ในการดาวน์โหลดและใช้งาน STAYALIVE คุณตกลงที่จะปฏิบัติตามและผูกพันตามข้อกำหนดและเงื่อนไขเหล่านี้'
          },
          {
            'title': '2. ข้อสงวนสิทธิ์ทางการแพทย์',
            'body':
                'STAYALIVE เป็นเครื่องมือแนะนำและไม่ใช่สิ่งทดแทนคำแนะนำทางการแพทย์ การวินิจฉัย หรือการรักษาโดยผู้เชี่ยวชาญ ควรขอคำแนะนำจากแพทย์หรือผู้ให้บริการด้านสุขภาพที่มีคุณสมบัติเหมาะสมเสมอเมื่อมีคำถามเกี่ยวกับสภาวะทางการแพทย์'
          },
          {
            'title': '3. การเข้าถึงตำแหน่งที่ตั้ง',
            'body':
                'เพื่อให้บริการคุณสมบัติ เช่น "ค้นหาโรงพยาบาล" แอปอาจขอเข้าถึงตำแหน่งที่ตั้งของอุปกรณ์ของคุณ ข้อมูลนี้ถูกใช้เพื่อวัตถุประสงค์ในการระบุสถานพยาบาลที่อยู่ใกล้เคียงเท่านั้น และไม่มีการจัดเก็บหรือแบ่งปันเพื่อวัตถุประสงค์อื่น'
          },
          {
            'title': '4. ข้อจำกัดความรับผิดชอบ',
            'body':
                'นักพัฒนา STAYALIVE จะไม่รับผิดชอบต่อความเสียหายใดๆ ที่เกิดจากการใช้งานหรือการไม่สามารถใช้งานแอปพลิเคชันได้'
          }
        ]
      },
      'privacy_page': {
        'title': 'นโยบายความเป็นส่วนตัว',
        'last_updated': 'แก้ไขล่าสุด: มีนาคม 2569',
        'sections': [
          {
            'title': '1. ข้อมูลที่เรารวบรวม',
            'body':
                'STAYALIVE ถูกออกแบบมาเพื่อเคารพความเป็นส่วนตัวของคุณ เราไม่ต้องการการลงทะเบียนบัญชี เราอาจรวบรวมข้อมูลการใช้งานที่ไม่สามารถระบุตัวตนได้เพื่อปรับปรุงประสิทธิภาพของแอป'
          },
          {
            'title': '2. ข้อมูลตำแหน่งที่ตั้ง',
            'body':
                'ข้อมูลตำแหน่งที่ตั้งจะถูกประมวลผลภายในอุปกรณ์ของคุณเพื่อค้นหาโรงพยาบาลที่อยู่ใกล้เคียง เราไม่ส่งหรือจัดเก็บตำแหน่งที่แน่นอนของคุณบนเซิร์ฟเวอร์ของเรา'
          },
          {
            'title': '3. ความปลอดภัยของข้อมูล',
            'body':
                'เรามาตรการรักษาความปลอดภัยที่เป็นมาตรฐานเพื่อปกป้องข้อมูลใดๆ ที่ประมวลผลโดยแอป'
          }
        ]
      },
      'medical_ref_page': {
        'title': 'อ้างอิงทางการแพทย์',
        'desc':
            'เนื้อหา STAYALIVE อ้างอิงจากหลักเกณฑ์ทางการแพทย์ฉุกเฉินที่เป็นสากล',
        'reviewer': {
          'title': 'ตรวจสอบทางการแพทย์โดย',
          'name': 'Carissa Stephens, R.N., CCRN, CPN',
          'author': 'โดย Amanda Barrell',
          'update_info':
              'อัปเดตเมื่อวันที่ 9 มกราคม 2569 จากเว็บไซต์ข่าวสารทางการแพทย์ (www.medicalnewstoday.com)',
          'bio':
              'Carissa Stephens เป็นพยาบาลเด็กที่มีความเชี่ยวชาญพิเศษด้าน extracorporeal membrane oxygenation (ECMO) ปัจจุบันเธอเป็นพยาบาลในหน่วยดูแลผู้ป่วยหนักเด็กที่ Dell Children\'s Medical Center of Central Texas'
        },
        'references': [
          {
            'source': 'American Health Care Academy',
            'detail':
                'ผู้ให้บริการฝึกอบรม CPR, การปฐมพยาบาล และการช่วยชีวิตขั้นพื้นฐาน (BLS) ที่ได้รับการรับรอง'
          },
          {
            'source': 'American Heart Association (AHA)',
            'detail':
                'หลักเกณฑ์สำหรับการทำ CPR และการดูแลผู้ป่วยฉุกเฉินทางระบบหัวใจและหลอดเลือด (ECC)'
          },
          {
            'source':
                'International Liaison Committee on Resuscitation (ILCOR)',
            'detail': 'มติสากลว่าด้วยวิทยาการ CPR และ ECC พร้อมข้อแนะนำการรักษา'
          },
          {
            'source': 'สภากาชาดไทย',
            'detail': 'แนวทางการฝึกอบรมการปฐมพยาบาลและการทำ CPR สำหรับประเทศไทย'
          }
        ]
      },
      'help_page': {
        'title': 'คู่มือการใช้งาน',
        'sections': [
          {
            'title': '1. หน้าแรก & หน้าสอนการใช้งาน',
            'body':
                'เมื่อผู้ใช้เปิดแอปพลิเคชัน จะพบกับ หน้าสอนการใช้งาน (Tutorials) ในการใช้งานครั้งแรก ซึ่งจะแนะนำวิธีการใช้งานแอปและให้ความรู้พื้นฐานเกี่ยวกับ CPR หลังจากจบขั้นตอนดังกล่าว ระบบจะพาผู้ใช้ไปยังหน้าหลัก โดยผู้ใช้สามารถกด Skip เพื่อข้ามไปยังขั้นตอนสุดท้ายได้'
          },
          {
            'title': '2. เริ่มต้นใช้งาน',
            'body':
                'หลังจากนั้น ระบบจะแสดงหน้า Terms and Conditions of Service ซึ่งผู้ใช้จำเป็นต้องกดยอมรับก่อนจึงจะสามารถใช้งานแอปพลิเคชันได้ ระบบจะทำการขอสิทธิ์ในการเข้าถึงการใช้งานบางอย่าง เช่น ตำแหน่ง (Location) หากผู้ใช้กด X ระบบยังคงอนุญาตให้ใช้งานแอปได้ตามปกติ แต่เมื่อผู้ใช้เรียกใช้ฟีเจอร์ที่ต้องการสิทธิ์ดังกล่าว ระบบจะทำการขออนุญาตอีกครั้ง'
          },
          {
            'title': '3. เริ่มทำ CPR',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Start ระบบจะแสดงหน้าต่างเพื่อให้ผู้ใช้เลือก ช่วงอายุของผู้ป่วย และสามารถเลือก Emergency Call เพื่อให้ระบบติดต่อไปยังโรงพยาบาลที่ใกล้ที่สุดได้ เมื่อผู้ใช้กด Next Step ระบบจะแสดงข้อมูลและคำแนะนำแบบสรุป เมื่อผู้ใช้กด Start CPR ระบบจะพาไปยังหน้าช่วยเหลือ ซึ่งประกอบด้วย ตัวจับเวลาในแต่ละรอบ, ช่องแสดงประเภทของผู้ป่วยที่เลือก, ตัวนับจำนวนรอบของการทำ CPR ซึ่งจะเพิ่มขึ้นเรื่อย ๆ จนถึงจำนวนที่กำหนด เมื่อครบกำหนด ระบบจะส่งสัญญาณแจ้งเตือน พร้อมช่องแสดงสถานะ และปุ่มหยุดการทำ CPR'
          },
          {
            'title': '4. คู่มือด่วน',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Quick Guide ระบบจะแสดงขั้นตอนการช่วยเหลือและการสังเกตอาการของผู้ป่วยที่อาจต้องทำ CPR ผู้ใช้สามารถเลื่อนหน้าจอเพื่อดูข้อมูลเพิ่มเติมได้ เมื่อผู้ใช้เลือก อาการของผู้ป่วย ระบบจะนำทางไปยังหน้าที่เกี่ยวข้องภายใน 5 วินาที โดยหน้าดังกล่าวจะแสดงข้อมูลอาการของผู้ป่วย และ ตำแหน่งปัจจุบันของผู้ใช้ ผู้ใช้สามารถกด Emergency Call เพื่อติดต่อโรงพยาบาล และในหน้าสุดท้ายจะมีตัวเลือก Start CPR หากผู้ใช้ต้องการทำ CPR ด้วยตนเอง'
          },
          {
            'title': '5. โทรฉุกเฉิน',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Emergency Call ระบบจะแสดงหน้าข้อมูลเกี่ยวกับ หน่วยฉุกเฉินที่สำคัญในประเทศไทย พร้อมปุ่ม Emergency Call สำหรับติดต่อโรงพยาบาล'
          },
          {
            'title': '6. ค้นหาโรงพยาบาล',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Find Hospital ระบบจะแสดงหน้าค้นหาโรงพยาบาล โดยมี ช่องค้นหา สำหรับพิมพ์ชื่อโรงพยาบาล หากผู้ใช้ไม่ได้พิมพ์ข้อความใด ๆ ระบบจะแสดง รายชื่อโรงพยาบาลที่อยู่ใกล้ที่สุด เมื่อผู้ใช้เลือกโรงพยาบาล ระบบจะแสดง แผนที่เส้นทางระหว่างตำแหน่งของผู้ใช้และโรงพยาบาล และผู้ใช้สามารถซูมแผนที่ได้'
          },
          {
            'title': '7. แบบทดสอบ',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Quick Test ระบบจะแสดงหน้า แบบทดสอบ หากผู้ใช้ตอบถูก ระบบจะไฮไลท์คำตอบที่ถูกต้องพร้อมแสดงคำอธิบาย หากผู้ใช้ตอบผิด ระบบจะแสดงคำตอบที่ถูกต้อง โดยไฮไลท์ตัวเลือกที่ถูกด้วย สีเขียว และตัวเลือกที่ผิดด้วย สีแดง พร้อมแสดงคำอธิบาย ผู้ใช้สามารถกด Next เพื่อไปยังคำถามถัดไป และ Previous เพื่อกลับไปยังคำถามก่อนหน้า'
          },
          {
            'title': '8. เมนูบทเรียน',
            'body':
                'เมื่อผู้ใช้เลือกเมนู Tutorials ระบบจะแสดงคำแนะนำการใช้งานแอปและความรู้พื้นฐานเกี่ยวกับ CPR เมื่อถึงขั้นตอนสุดท้าย ผู้ใช้สามารถกดปุ่มเพื่อไปยังหน้าหลัก หรือกด Skip เพื่อข้ามไปยังขั้นตอนสุดท้ายได้'
          },
          {
            'title': '9. การตั้งค่า',
            'body':
                'เมื่อผู้ใช้กด ไอคอนรูปเฟืองที่มุมขวาบน ระบบจะนำผู้ใช้ไปยังหน้า Settings ซึ่งประกอบด้วยเมนูต่าง ๆ ดังนี้ Notifications (ตั้งค่าการแจ้งเตือน), Configuration (ตั้งค่าระบบ), Privacy (ความเป็นส่วนตัว), Language (เปลี่ยนภาษา), Help (คู่มือการใช้งาน), Terms and Conditions (ข้อตกลงทางกฎหมาย), Privacy Policy (นโยบายความเป็นส่วนตัว) และ Medical References (แหล่งอ้างอิงข้อมูลทางการแพทย์)'
          }
        ]
      }
    },
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
        'selected_language', languageCode); // บันทึกค่าลงเครื่อง

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

  Map<String, dynamic> getPerformCprRules() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['cpr_perform_rules'] ?? {});
  }

  Map<String, dynamic> getNotPerformCprRules() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['cpr_not_perform_rules'] ?? {});
  }

  Map<String, String> getQuickGuideAgeSelect() {
    return Map<String, String>.from(
        _content[_currentLocale.languageCode]?['quick_guide_age_select'] ?? {});
  }

  List<Map<String, dynamic>> getQuickGuideAdultCpr() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_adult_cpr'] ?? []);
  }

  List<Map<String, dynamic>> getQuickGuideChildCpr() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_guide_child_cpr'] ?? []);
  }

  List<Map<String, dynamic>> getQuickTestQuestions() {
    return List<Map<String, dynamic>>.from(
        _content[_currentLocale.languageCode]?['quick_test_questions'] ?? []);
  }

  Map<String, dynamic> getTermsPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['terms_page'] ?? {});
  }

  Map<String, dynamic> getPrivacyPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['privacy_page'] ?? {});
  }

  Map<String, dynamic> getMedicalRefPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['medical_ref_page'] ?? {});
  }

  Map<String, dynamic> getHelpPage() {
    return Map<String, dynamic>.from(
        _content[_currentLocale.languageCode]?['help_page'] ?? {});
  }
}
