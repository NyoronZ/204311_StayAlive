/*
 * File: emergency_call_button.dart
 * Description: Reusable button widget that triggers a local notification
 *              reminder and then launches the phone dialer for emergency calls.
 *
 * Dependencies:
 * - LanguageProvider
 * - NotificationService
 * - url_launcher
 *
 * Lifecycle:
 * - Created as part of any screen that needs an emergency call action
 * - Disposed when the parent screen is removed from the tree
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/language_provider.dart';
import '../core/notification_service.dart';

/// A styled button that shows a reminder notification then dials an
/// emergency phone number.
///
/// Fields:
/// - phoneNumber: the number to dial when the button is tapped
/// - label: optional override for the button label text;
///   defaults to the [LanguageProvider] 'call_now' string
///
/// Usage:
/// - Placed in the CPR-required card inside [SymptomCheckCard]
/// - Can be reused on any screen that needs a one-tap emergency call
class EmergencyCallButton extends StatelessWidget {
  /// The phone number to dial when the button is tapped.
  final String phoneNumber;

  /// Optional label text; falls back to the localised 'call_now' string.
  final String? label;

  /// Creates an [EmergencyCallButton].
  ///
  /// [phoneNumber] is required. [label] is optional.
  const EmergencyCallButton({
    super.key,
    required this.phoneNumber,
    this.label,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri.parse("tel:$phoneNumber");

    try {
      if (!await launchUrl(launchUri))
        throw Exception('Could not launch $launchUri');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Builds the emergency call button with a phone icon and label.
  ///
  /// Side effects:
  /// - On tap: shows a [NotificationService] reminder notification,
  ///   then calls [_makePhoneCall] to open the system phone dialer
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const Color primaryGreen = Color(0xFF10B981);

    return InkWell(
      onTap: () async {
        // Trigger the system-level notification popup first, then launch the phone dialer.
        await NotificationService().showNotification(
          id: 0,
          title: lang.translate('home', 'emergency_call'),
          body: lang.translate('emergency_call', 'return_reminder'),
        );
        _makePhoneCall(phoneNumber);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primaryGreen.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.phone, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              label ?? lang.translate('emergency_call', 'call_now'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
