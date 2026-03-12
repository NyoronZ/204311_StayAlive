import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';

class HowToCprScreen extends StatelessWidget {
  const HowToCprScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final performCprData = lang.getPerformCprRules();
    final notPerformCprData = lang.getNotPerformCprRules();

    const primaryColor = Color(0xFF10B981);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      children: [
        _buildInfoCard(
          title: performCprData['title']!,
          color: Colors.blueAccent,
          items: (performCprData['list_items'] as List)
              .map((item) => '${item['title']}: ${item['desc']}')
              .toList(),
        ),
        const SizedBox(height: 15),
        _buildInfoCard(
          title: notPerformCprData['title']!,
          color: Colors.redAccent,
          items: (notPerformCprData['list_items'] as List)
              .map((item) => '${item['title']}: ${item['desc']}')
              .toList(),
        ),
        const Divider(height: 40, thickness: 2),
        _buildSectionTitle(
            lang.translate('how_to_cpr_screen', 'adult_cpr'), primaryColor),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step1_title'),
          lang.translate('how_to_cpr_screen', 'adult_step1_desc'),
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step2_title'),
          lang.translate('how_to_cpr_screen', 'adult_step2_desc'),
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step3_title'),
          lang.translate('how_to_cpr_screen', 'adult_step3_desc'),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle(
            lang.translate('how_to_cpr_screen', 'cpr_steps_title'),
            primaryColor),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step4_title'),
          lang.translate('how_to_cpr_screen', 'adult_step4_desc'),
          imagePath: 'assets/images/cpr.png',
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step5_title'),
          lang.translate('how_to_cpr_screen', 'adult_step5_desc'),
          imagePath: 'assets/images/breath.png',
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'adult_step6_title'),
          lang.translate('how_to_cpr_screen', 'adult_step6_desc'),
        ),
        const Divider(height: 40, thickness: 2),
        _buildSectionTitle(
            lang.translate('how_to_cpr_screen', 'child_cpr_title'),
            Colors.orange),
        Text(
          lang.translate('how_to_cpr_screen', 'child_cpr_desc'),
          style: const TextStyle(fontSize: 15, height: 1.4),
        ),
        const SizedBox(height: 10),
        _buildBulletPoint(lang.translate('how_to_cpr_screen', 'child_bullet1')),
        _buildBulletPoint(lang.translate('how_to_cpr_screen', 'child_bullet2')),
        const SizedBox(height: 20),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step1_title'),
          lang.translate('how_to_cpr_screen', 'child_step1_desc'),
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step2_title'),
          lang.translate('how_to_cpr_screen', 'child_step2_desc'),
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step3_title'),
          lang.translate('how_to_cpr_screen', 'child_step3_desc'),
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step4_title'),
          lang.translate('how_to_cpr_screen', 'child_step4_desc'),
          imagePath: 'assets/images/breath_infant.png',
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step5_title'),
          lang.translate('how_to_cpr_screen', 'child_step5_desc'),
          imagePath: 'assets/images/cpr_infant.png',
        ),
        _buildStep(
          lang.translate('how_to_cpr_screen', 'child_step6_title'),
          lang.translate('how_to_cpr_screen', 'child_step6_desc'),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStep(String title, String description, {String? imagePath}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border(left: BorderSide(color: color, width: 4)),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
              )),
        ],
      ),
    );
  }
}
