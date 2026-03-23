/*
 * File: terms_screen.dart
 * Description: Read-only screen displaying the Terms and Conditions
 *              as a scrollable list of localised sections.
 *
 * Dependencies:
 * - LanguageProvider
 * - CustomAppBar
 *
 * Lifecycle:
 * - Pushed via Navigator from the Settings screen
 * - Disposed when the user navigates back
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/custom_app_bar.dart';

/// Read-only screen that displays the Terms and Conditions.
///
/// Fields:
/// - (stateless) — no mutable state
///
/// Usage:
/// - Navigated to from the Settings screen for reference only
/// - Renders a last-updated timestamp and a list of T\&C sections
class TermsScreen extends StatelessWidget {
  /// Creates a [TermsScreen].
  const TermsScreen({super.key});

  /// Builds the terms screen with a last-updated timestamp and
  /// a scrollable list of T\&C sections from [LanguageProvider].
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final termsData = lang.getTermsPage();
    final List<dynamic> sections = termsData['sections'] ?? [];
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(title: termsData['title'] ?? ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (termsData['last_updated'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  termsData['last_updated'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ...sections.map((section) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['title'] ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      section['body'] ?? "",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[300]
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
