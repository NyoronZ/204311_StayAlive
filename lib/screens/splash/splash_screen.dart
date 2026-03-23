/*
 * File: splash_screen.dart
 * Description: Initial loading screen shown on app start.
 *              Precaches images, checks Terms acceptance and tutorial
 *              completion, then routes to the appropriate screen.
 *
 * Dependencies:
 * - PrivacyProvider
 * - SharedPreferences (to read hasSeenTutorial flag)
 *
 * Lifecycle:
 * - Created as the app's initial route
 * - Disposed immediately after routing to the next screen
 *
 * Author: Nohimitsu
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../core/privacy_provider.dart';

/// Splash/loading screen shown while the app initialises.
///
/// Fields:
/// - (stateless) — all state is held in [_LoadingScreenState]
///
/// Usage:
/// - Set as the initial route in the app
/// - Precaches logo images and routes to Terms, Tutorial, or Home
class LoadingScreen extends StatefulWidget {
  /// Creates a [LoadingScreen].
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /// Initialises the state and schedules [_loadComponents] after
  /// the first frame to ensure the widget tree is fully mounted.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadComponents();
    });
  }

  Future<void> _loadComponents() async {
    final privacyProvider =
        Provider.of<PrivacyProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final hasSeenTutorial = prefs.getBool('hasSeenTutorial') ?? false;

    if (!mounted) return;
    await Future.wait([
      precacheImage(
          const AssetImage('assets/images/stayalive_logo.png'), context),
      precacheImage(
          const AssetImage('assets/images/stayalive_logo_dark.png'), context),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    if (!mounted) return;

    if (!privacyProvider.hasAcceptedTerms) {
      Navigator.pushReplacementNamed(context, '/terms-consent');
    } else {
      Navigator.pushReplacementNamed(
        context,
        hasSeenTutorial ? '/home' : '/tutorial',
      );
    }
  }

  /// Builds the splash screen with the app logo and a loading spinner.
  ///
  /// Adapts the background colour to the current theme (dark/light).
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFF10B981),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // heart icon
            // Icon(Icons.favorite, size: 120, color: Colors.white),
            Image(
              image: AssetImage('assets/images/cropped_app_logo.png'),
              height: 140,
              width: 140,
            ),
            SizedBox(height: 60),
            // loading spinner
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
