import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
