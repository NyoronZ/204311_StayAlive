/*
 * File: privacy_settings_screen.dart
 * Description: Settings screen for managing location permission
 *              and Terms and Conditions acceptance state.
 *
 * Dependencies:
 * - LanguageProvider
 * - PrivacyProvider
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
import 'package:flutter/services.dart';
import '../../core/language_provider.dart';
import '../../core/privacy_provider.dart';
import '../../components/custom_app_bar.dart';

/// Screen for managing privacy-related permissions and consent.
///
/// Fields:
/// - (stateless) — no mutable state
///
/// Usage:
/// - Pushed from the Settings screen
/// - Allows the user to toggle location permission and T\&C acceptance
/// - Shows a warning dialog before revoking terms consent
class PrivacySettingsScreen extends StatelessWidget {
  /// Creates a [PrivacySettingsScreen].
  const PrivacySettingsScreen({super.key});

  /// Builds the privacy settings screen with location and T\&C toggles.
  ///
  /// Side effects:
  /// - Toggling location calls [PrivacyProvider.toggleLocation] and may
  ///   show a SnackBar if the permission request fails
  /// - Revoking T\&C calls [_showTermsWarning] which exits the app on confirm
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final privacyProvider = Provider.of<PrivacyProvider>(context);
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(title: lang.translate('settings', 'privacy')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            // Location Permission Switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primaryColor,
              title: Text(
                lang.translate('settings', 'loc_permission'),
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: Text(
                lang.translate('settings', 'loc_permission_desc'),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black54,
                ),
              ),
              value: privacyProvider.locationEnabled,
              onChanged: (bool value) async {
                bool success = await privacyProvider.toggleLocation(value);
                if (!success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(lang.translate('settings', 'loc_required'))),
                  );
                }
              },
            ),
            const Divider(),
            // Terms and Conditions Switch
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primaryColor,
              title: Text(
                lang.translate('settings', 'accept_terms'),
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
                ),
              ),
              subtitle: Text(
                lang.translate('settings', 'accept_terms_desc'),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black54,
                ),
              ),
              value: privacyProvider.hasAcceptedTerms,
              onChanged: (bool value) {
                if (!value) {
                  _showTermsWarning(context, privacyProvider, lang);
                } else {
                  privacyProvider.toggleTerms(true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsWarning(BuildContext context, PrivacyProvider provider, LanguageProvider lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lang.translate('settings', 'revoke_title')),
        content: Text(lang.translate('settings', 'revoke_desc')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(lang.translate('settings', 'cancel')),
          ),
          TextButton(
            onPressed: () {
              provider.toggleTerms(false);
              Navigator.pop(context);
              SystemNavigator.pop(); // Quit app
            },
            child: Text(
              lang.translate('settings', 'revoke_btn'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
