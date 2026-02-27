import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/language_provider.dart';

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

    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const Color primaryGreen = Color(0xFF0D9B58);

    return InkWell(
      onTap: () => _makePhoneCall(phoneNumber),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: primaryGreen, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
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
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.phone, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            Text(
              label ?? lang.translate('emergency_call', 'call_now'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
