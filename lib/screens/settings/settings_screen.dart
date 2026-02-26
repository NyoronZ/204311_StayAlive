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
      // CustomAppBar 
      appBar: const CustomAppBar(title: "Settings"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: USER ---
            const Text("user", style: sectionTitleStyle),
            const SizedBox(height: 10),
            _buildSettingItem(
              title: "Notifications", 
              onTap: () => debugPrint("Navigate to Notifications"),
            ),
            _buildSettingItem(
              title: "Configuration", 
              onTap: () => debugPrint("Navigate to Configuration"),
            ),
            _buildSettingItem(
              title: "Privacy", 
              onTap: () => debugPrint("Navigate to Privacy"),
            ),
            // LanguageProvider
            _buildSettingItem(
              title: "Language", 
              subtitle: lang.currentLocale.languageCode == 'en' ? 'English' : 'ไทย',
              onTap: () => _showLanguagePicker(context, lang),
            ),
            
            const SizedBox(height: 10),
            const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 10),

            // --- Section: SUPPORTING (Other items) ---
            const Text("supporting", style: sectionTitleStyle),
            const SizedBox(height: 10),
            _buildSettingItem(
              title: "Help", 
              onTap: () => debugPrint("Navigate to Help"),
            ),
            _buildSettingItem(
              title: "Feedback", 
              onTap: () => debugPrint("Navigate to Feedback"),
            ),

            const SizedBox(height: 40),

            // --- Footer Links ---
            _buildFooterLink("Terms and Conditions of Service", primaryColor, onTap: () {}),
            _buildFooterLink("Privacy Policy", primaryColor, onTap: () {}),
            _buildFooterLink("Medical References", primaryColor, onTap: () {}),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Menu Widget
  Widget _buildSettingItem({
    required String title, 
    String? subtitle, 
    required VoidCallback onTap
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Color(0xFF10B981))) : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
      onTap: onTap,
    );
  }

  // green Widget
  Widget _buildFooterLink(String text, Color color, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // modal bottom sheet
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Select Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF10B981)),
              title: const Text("ไทย"),
              trailing: lang.currentLocale.languageCode == 'th' ? const Icon(Icons.check, color: Color(0xFF10B981)) : null,
              onTap: () {
                lang.changeLanguage('th');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF10B981)),
              title: const Text("English"),
              trailing: lang.currentLocale.languageCode == 'en' ? const Icon(Icons.check, color: Color(0xFF10B981)) : null,
              onTap: () {
                lang.changeLanguage('en');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}