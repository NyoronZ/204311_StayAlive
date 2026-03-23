/*
 * File: splash_screen.dart
 * Description: Displays the initial loading screen while preloading assets
 *              and determining the initial route based on user state.
 *
 * Dependencies:
 * - SharedPreferences (Local storage)
 * - Provider (PrivacyProvider)
 *
 * Lifecycle:
 * - Created via Navigator
 * - Disposed when user navigates away or replaced by home/tutorial
 *
 * Responsibilities:
 * - Preloads essential image assets
 * - Checks privacy consent and routes the user accordingly
 *
 * Author: Nohimitsu
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../core/privacy_provider.dart';

/// The initial splash screen displayed when the application launches.
class LoadingScreen extends StatefulWidget {
  /// Whether the app should render its initial state in dark mode.
  final bool initialIsDark;

  const LoadingScreen({super.key, required this.initialIsDark});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadComponents();
  }

  // Preloads assets and determines the next route based on user data.
  Future<void> _loadComponents() async {
    final privacyProvider =
        Provider.of<PrivacyProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();

    // Whether the user has previously completed the tutorial.
    final hasSeenTutorial = prefs.getBool('hasSeenTutorial') ?? false;

    if (!mounted) return;

    // Preload critical assets and add an artificial delay for smooth transition.
    await Future.wait([
      precacheImage(
          const AssetImage('assets/images/stayalive_logo.png'), context),
      precacheImage(
          const AssetImage('assets/images/stayalive_logo_dark.png'), context),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    if (!mounted) return;

    // Route based on terms acceptance and tutorial completion.
    if (!privacyProvider.hasAcceptedTerms) {
      Navigator.pushReplacementNamed(context, '/terms-consent');
    } else {
      Navigator.pushReplacementNamed(
        context,
        hasSeenTutorial ? '/home' : '/tutorial',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.initialIsDark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFF10B981),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/cropped_app_logo.png'),
              height: 140,
              width: 140,
            ),
            SizedBox(height: 60),
            // Loading spinner
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
