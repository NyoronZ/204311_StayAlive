import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const primaryColor = Color(0xFF10B981); 
    const sectionTitleStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16, 
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // use CustomAppBar with translated title from LanguageProvider
      appBar: CustomAppBar(title: lang.translate('settings', 'title')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: USER ---
            Text(lang.translate('settings', 'user_sec'), style: sectionTitleStyle),
            const SizedBox(height: 5),
            _buildSettingItem(
              title: lang.translate('settings', 'notifications'), 
              onTap: () => debugPrint("Navigate to Notifications"),
            ),
            _buildSettingItem(
              title: lang.translate('settings', 'config'), 
              onTap: () => debugPrint("Navigate to Configuration"),
            ),
            _buildSettingItem(
              title: lang.translate('settings', 'privacy'), 
              onTap: () => debugPrint("Navigate to Privacy"),
            ),
            _buildSettingItem(
              title: lang.translate('settings', 'language'), 
              subtitle: lang.currentLocale.languageCode == 'en' ? 'English' : 'ไทย',
              onTap: () => _showLanguagePicker(context, lang),
            ),
            
            const SizedBox(height: 15),
            const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 15),

            // --- Section: SUPPORTING ---
            Text(lang.translate('settings', 'support_sec'), style: sectionTitleStyle),
            const SizedBox(height: 5),
            _buildSettingItem(
              title: lang.translate('settings', 'help'), 
              onTap: () => debugPrint("Navigate to Help"),
            ),
            _buildSettingItem(
              title: lang.translate('settings', 'feedback'), 
              onTap: () => debugPrint("Navigate to Feedback"),
            ),

            const SizedBox(height: 40),

            // --- Footer Links ---
            _buildFooterLink(lang.translate('settings', 'terms'), primaryColor, onTap: () {}),
            _buildFooterLink(lang.translate('settings', 'privacy_pol'), primaryColor, onTap: () {}),
            _buildFooterLink(lang.translate('settings', 'medical_ref'), primaryColor, onTap: () {}),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // adjust row less gap by visualDensity and contentPadding
  Widget _buildSettingItem({
    required String title, 
    String? subtitle, 
    required VoidCallback onTap
  }) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Color(0xFF10B981), fontSize: 14)) : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildFooterLink(String text, Color color, {required VoidCallback onTap}) {
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
              child: Text(
                lang.translate('settings', 'select_lang'), 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
            ),
            _buildLanguageOption(
              context, 
              lang, 
              label: "ไทย", 
              code: 'th', 
              icon: Icons.language
            ),
            _buildLanguageOption(
              context, 
              lang, 
              label: "English", 
              code: 'en', 
              icon: Icons.language
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // adjust icon and text gap by horizontalTitleGap
  Widget _buildLanguageOption(BuildContext context, LanguageProvider lang, {required String label, required String code, required IconData icon}) {
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
          color: isSelected ? primaryColor : Colors.black,
        ),
      ),
      trailing: isSelected 
          ? const Icon(Icons.check, color: primaryColor) 
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
    );
  }
}