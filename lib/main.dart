/*
 * File: main.dart
 * Description: Entry point of the application that initializes core services,
 *              sets up global state management using providers, and configures
 *              application themes, routing, and UI behavior.
 *
 * Responsibilities:
 * - Initializes notification service and requests permissions
 * - Configures MultiProvider for global state management
 * - Sets up application routes and navigation
 * - Applies light and dark themes
 * - Handles global text scaling and UI configuration
 *
 * Author: Nohimitsu
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/language_provider.dart';
import 'core/notification_provider.dart';
import 'core/theme_provider.dart';
import 'core/privacy_provider.dart';
import 'core/notification_service.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/tutorial/tutorial.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/other/quick_test_screen.dart';
import 'screens/emergency/emergency_call_screen.dart';
import 'screens/emergency/find_hospital_screen.dart';
import 'screens/cpr/cpr_select_age_screen.dart';
import 'screens/emergency/quick_guide_screen.dart';
import 'screens/legal/terms_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/legal/medical_references_screen.dart';
import 'screens/legal/terms_consent_screen.dart';
import 'screens/settings/privacy_settings_screen.dart';
import 'screens/settings/help_screen.dart';

/// Entry point of the application.
///
/// Initializes required services before running the app.
void main() async {
  // FOR DEBUGGING UI LAYOUT ONLY
  debugPaintSizeEnabled = false;

  // Ensures Flutter binding is initialized before async operations.
  WidgetsFlutterBinding.ensureInitialized();

  // Pull the theme settings.
  final prefs = await SharedPreferences.getInstance();
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  // Initialize notification service and request permissions.
  final notifService = NotificationService();
  await notifService.init();
  await notifService.requestPermissions();

  // Run the app with multiple providers.
  runApp(
    MultiProvider(
      providers: [
        // Manages language and localization
        ChangeNotifierProvider(create: (context) => LanguageProvider()),

        // Manages notification settings
        ChangeNotifierProvider(create: (context) => NotificationProvider()),

        // Manages theme (light/dark mode)
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // Manages privacy settings
        ChangeNotifierProvider(create: (context) => PrivacyProvider()),
      ],
      child: StayAliveApp(isDarkMode: isDarkMode),
    ),
  );
}

/// Root widget of the application.
///
/// Configures themes, routes, and global UI behavior.
class StayAliveApp extends StatelessWidget {
  /// Whether the app should start in dark mode.
  final bool isDarkMode;

  /// Creates the main application widget.
  const StayAliveApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    const primaryColor = Color(0xFF10B981);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Application title
      title: 'Stay Alive',

      // Light theme configuration
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        primaryColor: primaryColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),

      // Dark theme configuration
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

      // Controls current theme mode
      themeMode: themeProvider.themeMode,

      // Applies global text scaling
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(themeProvider.fontSizeFactor),
          ),
          child: child!,
        );
      },

      // Initial route
      initialRoute: '/',

      // Application routes
      routes: {
        '/': (context) => LoadingScreen(initialIsDark: isDarkMode),
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