import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/language_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/tutorial/tutorial.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/other/quick_test_screen.dart';
import 'screens/emergency/emergency_call_screen.dart';
import 'screens/emergency/find_hospital_screen.dart';
import 'screens/cpr/cpr_select_age_screen.dart';
import 'screens/emergency/quick_guide_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const StayAliveApp(),
    ),
  );
}

class StayAliveApp extends StatelessWidget {
  const StayAliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stay Alive',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/tutorial': (context) => const TutorialScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/quick-test': (context) => const QuickTestScreen(),
        '/emergency-call': (context) => const EmergencyCallScreen(),
        '/find-hospital': (context) => const FindHospitalScreen(),
        '/start': (context) => const CprSelectAgeScreen(),
        '/quick-guide': (context) => const QuickGuideScreen(),
      },
    );
  }
}
