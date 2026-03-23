/*
 * File: help_screen.dart
 * Description: Displays a localised help guide as a scrollable list
 *              of section cards sourced from LanguageProvider.
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

/// Displays a localised help guide for the StayAlive app.
///
/// Fields:
/// - (stateless) — no mutable state
///
/// Usage:
/// - Pushed from the Settings screen
/// - Renders each help topic as a card with a title and body text
class HelpScreen extends StatelessWidget {
  /// Creates a [HelpScreen].
  const HelpScreen({super.key});

  /// Builds the help screen as a [ListView] of section cards
  /// sourced from [LanguageProvider].
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final helpData = lang.getHelpPage();
    final String title = helpData['title'] ?? 'Help Guide';
    final List<dynamic> sections = helpData['sections'] ?? [];
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: sections.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final section = sections[index];
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  section['body'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[300]
                        : Colors.grey[800],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
