import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/language_provider.dart';
import '../core/notification_service.dart';

class EmergencyCallButton extends StatelessWidget {
  final String phoneNumber;
  final String? label;

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
