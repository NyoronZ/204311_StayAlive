/*
 * File: en.dart
 * Description: English (EN) locale string and data content for the StayAlive app.
 *              Imported by LanguageProvider to build the content map.
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

/// All English locale content used by [LanguageProvider].
const Map<String, dynamic> enContent = {
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
    'select_age_title': 'Select Patient Age',
    'infant': 'Infant',
    'infant_sub': 'Under 1 year',
    'child': 'Child',
    'child_sub': '1-8 years',
    'adult': 'Adult',
    'adult_sub': 'Over 8 years',
    'emergency_call': 'Emergency call',
    'next_step': 'Next Step',
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
        'Cardiopulmonary resuscitation is a life-saving technique used in emergencies when someone\u2019s breathing or heartbeat has stopped.',
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
        'If someone is awake and breathing, they don\u2019t need CPR. There are also certain situations where you shouldn\u2019t give CPR.',
    'list_items': [
      {
        'title': '1. Obvious Signs of Death',
        'desc':
            'Signs like rigor mortis or severe injuries where CPR would be futile.'
      },
      {
        'title': '2. Do Not Resuscitate (DNR) Orders',
        'desc': 'A legal document specifying a person\u2019s wish to forgo CPR.'
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
      'question': 'What is the primary purpose of chest compressions in CPR?',
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
          'The head-tilt, chin-lift maneuver opens the airway; if it\u2019s still blocked, reassess and continue CPR steps accordingly.'
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
      'question': 'What is the correct order of the CPR sequence for an adult?',
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
      'question': 'What is a key difference in CPR for a child versus an adult?',
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
          'In CPR, what does the "A" in the C-A-B sequence stand for?',
      'options': ['Assessment', 'Airway', 'Assistance', 'AED'],
      'answerIndex': 1,
      'explanation':
          '"A" stands for Airway, which involves opening the airway to allow for effective breathing.'
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
      'question': 'What is the correct hand placement for CPR on an infant?',
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
    'desc': 'STAYALIVE content is based on established emergency medical guidelines.',
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
  },
};
