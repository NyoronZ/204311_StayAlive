import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
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
import 'core/notification_service.dart';
import 'screens/legal/terms_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/legal/medical_references_screen.dart';
import 'screens/legal/terms_consent_screen.dart';
import 'screens/settings/privacy_settings_screen.dart';
import 'screens/settings/help_screen.dart';
import 'core/privacy_provider.dart';

import 'core/notification_provider.dart';
import 'core/theme_provider.dart';

void main() async {
  // OUTLINER: FOR DEBUGGING ONLY!!!
  debugPaintSizeEnabled = false;

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Background Local Notifications
  final notifService = NotificationService();
  await notifService.init();
  await notifService.requestPermissions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyProvider()),
      ],
      child: const StayAliveApp(),
    ),
  );
}

class StayAliveApp extends StatelessWidget {
  const StayAliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    const primaryColor = Color(0xFF10B981);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stay Alive',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        primaryColor: primaryColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        primaryColor: primaryColor,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      themeMode: themeProvider.themeMode,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(themeProvider.fontSizeFactor),
          ),
          child: child!,
        );
      },
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
        '/terms': (context) => const TermsScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
        '/medical-refs': (context) => const MedicalReferencesScreen(),
        '/terms-consent': (context) => const TermsAndConditionsConsentScreen(),
        '/privacy-settings': (context) => const PrivacySettingsScreen(),
        '/help': (context) => const HelpScreen(),
      },
    );
  }
}
