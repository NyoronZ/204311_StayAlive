import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Settings icon button
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF10B981), size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: STAY ALIVE
            const Center(
              child: Column(
                children: [
                  // TODO： Add application icon
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
                  // Icon(Icons.show_chart, color: Color(0xFF10B981), size: 40),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // START Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 70, color: Colors.white),
                  SizedBox(width: 25),
                  Text(
                    "START",
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 45, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Section: Emergency
            _buildSectionTitle("Emergency"),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton("Quick guide", Icons.person_search, true),
                _buildMenuButton("Emergency call", Icons.phone_in_talk, true),
                _buildMenuButton("Find hospital", Icons.local_hospital, true),
              ],
            ),
            const SizedBox(height: 40),

            // Section: Others
            _buildSectionTitle("Others"),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildMenuButton("Quick test", Icons.menu_book, false),
                const SizedBox(width: 20),
                _buildMenuButton("Tutorials", Icons.library_books, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for section title with arrow icon
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }

  // Widget for menu button
  Widget _buildMenuButton(String label, IconData icon, bool isSolid) {
    return Column(
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            color: isSolid ? const Color(0xFF10B981) : Colors.transparent,
            border: isSolid ? null : Border.all(color: const Color(0xFF10B981), width: 2),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon, 
            color: isSolid ? Colors.white : const Color(0xFF10B981), 
            size: 45
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}