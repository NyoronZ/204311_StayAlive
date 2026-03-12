import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';

class MedicalReferencesScreen extends StatelessWidget {
  const MedicalReferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final medicalData = lang.getMedicalRefPage();
    final List<dynamic> references = medicalData['references'] ?? [];
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(title: medicalData['title'] ?? ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (medicalData['desc'] != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  medicalData['desc'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            if (medicalData['reviewer'] != null)
              Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(color: primaryColor.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicalData['reviewer']['title'] ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      medicalData['reviewer']['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (medicalData['reviewer']['author'] != null ||
                        medicalData['reviewer']['update_info'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${medicalData['reviewer']['author'] ?? ""} — ${medicalData['reviewer']['update_info'] ?? ""}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      medicalData['reviewer']['bio'] ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ...references.map((ref) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.bookmark, color: primaryColor, size: 24),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref['source'] ?? "",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            ref['detail'] ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                        ],
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
