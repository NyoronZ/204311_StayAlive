/*
 * File: settings_screen.dart
 * Description: Main settings screen allowing the user to configure
 *              notifications, language, display options, and access
 *              legal/support pages.
 *
 * Dependencies:
 * - LanguageProvider
 * - NotificationProvider
 * - ThemeProvider
 * - CustomAppBar
 *
 * Lifecycle:
 * - Pushed via Navigator from the Home screen
 * - Disposed when the user navigates back
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../core/notification_provider.dart';
import '../../core/theme_provider.dart';
import '../../components/custom_app_bar.dart';

/// Main settings screen for configuring app preferences.
///
/// Fields:
/// - (stateless) — no mutable state
///
/// Usage:
/// - Pushed from the Home screen
/// - Provides controls for notifications, language, dark mode,
///   font size, and links to legal/support screens
class SettingsScreen extends StatelessWidget {
  /// Creates a [SettingsScreen].
  const SettingsScreen({super.key});

  /// Builds the settings screen with grouped sections for user
  /// preferences, display options, support links, and footer links.
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final notifProvider = Provider.of<NotificationProvider>(context);
    const primaryColor = Color(0xFF10B981);
    const sectionTitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      // use CustomAppBar with translated title from LanguageProvider
      appBar: CustomAppBar(title: lang.translate('settings', 'title')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: USER ---
            Text(lang.translate('settings', 'user_sec'),
                style: sectionTitleStyle),
            const SizedBox(height: 5),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primaryColor,
              title: Text(
                lang.translate('settings', 'notifications'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: notifProvider.notificationsEnabled,
              onChanged: (bool value) {
                notifProvider.toggleNotifications(value);
              },
            ),

            _buildSettingItem(
              title: lang.translate('settings', 'privacy'),
              onTap: () => Navigator.pushNamed(context, '/privacy-settings'),
            ),
            _buildSettingItem(
              title: lang.translate('settings', 'language'),
              subtitle:
                  lang.currentLocale.languageCode == 'en' ? 'English' : 'ไทย',
              onTap: () => _showLanguagePicker(context, lang),
            ),

            const SizedBox(height: 15),
            // --- Section: CONFIGURATION ---
            Text(lang.translate('settings', 'display_sec'),
                style: sectionTitleStyle),
            const SizedBox(height: 5),
            Consumer<ThemeProvider>(
              builder: (context, theme, child) => Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      lang.translate('settings', 'dark_mode'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    activeColor: primaryColor,
                    value: theme.isDarkMode,
                    onChanged: (value) => theme.toggleTheme(value),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        lang.translate('settings', 'text_size'),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        "${(theme.fontSizeFactor * 100).toInt()}%",
                        style: const TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Slider(
                    value: theme.fontSizeFactor,
                    min: 0.8,
                    max: 1.0,
                    divisions: 2,
                    activeColor: primaryColor,
                    label: "${(theme.fontSizeFactor * 100).toInt()}%",
                    onChanged: (value) => theme.setFontSizeFactor(value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 15),

            // --- Section: SUPPORTING ---
            Text(lang.translate('settings', 'support_sec'),
                style: sectionTitleStyle),
            const SizedBox(height: 5),
            _buildSettingItem(
              title: lang.translate('settings', 'help'),
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),

            const SizedBox(height: 40),

            // --- Footer Links ---
            _buildFooterLink(lang.translate('settings', 'terms'), primaryColor,
                onTap: () => Navigator.pushNamed(context, '/terms')),
            _buildFooterLink(
                lang.translate('settings', 'privacy_pol'), primaryColor,
                onTap: () => Navigator.pushNamed(context, '/privacy')),
            _buildFooterLink(
                lang.translate('settings', 'medical_ref'), primaryColor,
                onTap: () => Navigator.pushNamed(context, '/medical-refs')),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // adjust row less gap by visualDensity and contentPadding
  Widget _buildSettingItem(
      {required String title, String? subtitle, required VoidCallback onTap}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(color: Color(0xFF10B981), fontSize: 14))
          : null,
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildFooterLink(String text, Color color,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, LanguageProvider lang) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(lang.translate('settings', 'select_lang'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildLanguageOption(context, lang,
                label: "ไทย", code: 'th', icon: Icons.language),
            _buildLanguageOption(context, lang,
                label: "English", code: 'en', icon: Icons.language),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // adjust icon and text gap by horizontalTitleGap
  Widget _buildLanguageOption(BuildContext context, LanguageProvider lang,
      {required String label, required String code, required IconData icon}) {
    final isSelected = lang.currentLocale.languageCode == code;
    const primaryColor = Color(0xFF10B981);

    return ListTile(
      onTap: () {
        lang.changeLanguage(code);
        Navigator.pop(context);
      },
      leading: Icon(icon, color: primaryColor),
      horizontalTitleGap: 10,
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? primaryColor : null,
        ),
      ),
      trailing:
          isSelected ? const Icon(Icons.check, color: primaryColor) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
    );
  }
}
