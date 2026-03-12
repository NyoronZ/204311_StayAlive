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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevents unintended back button
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: primaryColor, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // --- Header Section ---
            Center(
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/stayalive_logo_dark.png'
                    : 'assets/images/stayalive_logo.png',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // --- START Button ---
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/start'),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
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
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          lang.translate('home', 'start'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Section: Emergency ---
            _buildSectionTitle(lang.translate('home', 'emergency')),
            const SizedBox(height: 15),
            // ใช้ Row เหมือนเดิม เพื่อบังคับให้อยู่บรรทัดเดียวกัน
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  label: lang.translate('home', 'quick_guide'),
                  icon: Icons.person_search,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/quick-guide'),
                ),
                _buildMenuButton(
                  label: lang.translate('home', 'emergency_call'),
                  icon: Icons.phone_in_talk,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/emergency-call'),
                ),
                _buildMenuButton(
                  label: lang.translate('home', 'find_hospital'),
                  icon: Icons.local_hospital,
                  isSolid: true,
                  onTap: () => Navigator.pushNamed(context, '/find-hospital'),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // --- Section: Others ---
            _buildSectionTitle(lang.translate('home', 'others')),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(
                  label: lang.translate('home', 'quick_test'),
                  icon: Icons.menu_book,
                  isSolid: false,
                  onTap: () => Navigator.pushNamed(context, '/quick-test'),
                ),
                _buildMenuButton(
                  label: lang.translate('home', 'tutorials'),
                  icon: Icons.library_books,
                  isSolid: false,
                  onTap: () => Navigator.pushNamed(context, '/tutorial'),
                ),
                // 🌟 ใส่ "กล่องล่องหน" กว้าง 85px เพื่อดึงระยะให้ปุ่มอื่นตรงกับแถวบนเป๊ะๆ
                const SizedBox(width: 85),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

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

  // 🌟 ปรับ Widget ปุ่มให้ถูกล็อกความกว้างไว้ที่ 85px เสมอ (กันตัวหนังสือดันกล่องจนเบี้ยว)
  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required bool isSolid,
    required VoidCallback onTap,
  }) {
    const primaryColor = Color(0xFF10B981);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 85, // ล็อกความกว้างรวมของปุ่ม
        child: Column(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: isSolid ? primaryColor : Colors.transparent,
                border:
                    isSolid ? null : Border.all(color: primaryColor, width: 2),
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
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
