import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: primaryColor, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section ---
            const Center(
              child: Column(
                children: [
                  Text(
                    "STAY ALIVE",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Icon(Icons.show_chart, color: primaryColor, size: 40),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- START Button ---
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/start'),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, size: 70, color: Colors.white),
                    const SizedBox(width: 15),
                    Flexible( // use Flexible to prevent overflow if text is too long
                      child: Text(
                        lang.translate('start'),
                        style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // if text is too long, show ellipsis
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Section: Emergency ---
            _buildSectionTitle(lang.translate('emergency')),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  label: lang.translate('quick_guide'),
                  icon: Icons.person_search,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/quick-guide'),
                ),
                _buildMenuButton(
                  label: lang.translate('emergency_call'),
                  icon: Icons.phone_in_talk,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/emergency-call'),
                ),
                _buildMenuButton(
                  label: lang.translate('find_hospital'),
                  icon: Icons.local_hospital,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/find-hospital'),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // --- Section: Others ---
            _buildSectionTitle(lang.translate('others')),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildMenuButton(
                  label: lang.translate('quick_test'),
                  icon: Icons.menu_book,
                  isSolid: false,
                  onTap: () => Navigator.pushNamed(context, '/quick-test'),
                ),
                const SizedBox(width: 20),
                _buildMenuButton(
                  label: lang.translate('tutorials'),
                  icon: Icons.library_books,
                  isSolid: false, 
                  onTap: () => Navigator.pushNamed(context, '/tutorial'),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget： Section (Emergency >, Others >)
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        const Icon(Icons.chevron_right, size: 28),
      ],
    );
  }

  // Widget (Emergency call, Find hospital, Quick test, Tutorials)
  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required bool isSolid,
    required VoidCallback onTap,
  }) {
    const primaryColor = Color(0xFF10B981);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: isSolid ? primaryColor : Colors.transparent,
              border: isSolid ? null : Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: isSolid ? Colors.white : primaryColor,
              size: 45,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}