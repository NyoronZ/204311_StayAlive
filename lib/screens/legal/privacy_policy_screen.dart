import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final privacyData = lang.getPrivacyPage();
    final List<dynamic> sections = privacyData['sections'] ?? [];
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(title: privacyData['title'] ?? ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (privacyData['last_updated'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  privacyData['last_updated'],
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
