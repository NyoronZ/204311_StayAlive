import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/shadow_card.dart';

class CprSuccessScreen extends StatelessWidget {
  final String ageGroup;
  final int totalTimeInSeconds;
  final int totalCompressions;
  final int totalCycles;

  const CprSuccessScreen({
    super.key,
    required this.ageGroup,
    required this.totalTimeInSeconds,
    required this.totalCompressions,
    required this.totalCycles,
  });

  String get formattedTime {
    int minutes = totalTimeInSeconds ~/ 60;
    int seconds = totalTimeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final Color primaryGreen = const Color(0xFF10B981);
    final Color lightGreen = const Color(0xFFC6F6D5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black54, size: 30),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: SizedBox(
            height: 680, // 👈 ใช้ความสูง 680 เท่ากับหน้า Timer
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 👈 ดันปุ่ม Done ลงไปล่างสุด
              children: [
                // --- 1. Success Circle ---
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: primaryGreen.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline,
                              color: Colors.white, size: 70),
                          const SizedBox(height: 10),
                          Text(
                            lang.translate('cpr', 'success'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // --- 2. Stats Box ---
                ShadowCard(
                  color: lightGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 15),
                    child: Column(
                      children: [
                        _buildStatRow(Icons.speed,
                            lang.translate('cpr', 'speed'), "120 BPM"),
                        const Divider(
                            color: Colors.white, thickness: 1.5, height: 25),
                        _buildStatRow(Icons.person_outline,
                            lang.translate('cpr', 'age'), lang.translate('cpr', ageGroup.toLowerCase())),
                        const Divider(
                            color: Colors.white, thickness: 1.5, height: 25),
                        _buildStatRow(Icons.timer_outlined,
                            lang.translate('cpr', 'time'), formattedTime),
                        const Divider(
                            color: Colors.white, thickness: 1.5, height: 25),
                        _buildStatRow(
                            Icons.monitor_heart_outlined,
                            lang
                                .translate('cpr', 'compressions')
                                .replaceAll(':', '')
                                .trim(),
                            "$totalCompressions"),
                        const Divider(
                            color: Colors.white, thickness: 1.5, height: 25),
                        _buildStatRow(
                            Icons.autorenew,
                            lang.translate('cpr', 'full_cycles'),
                            "$totalCycles"), // 👈 เปลี่ยนเป็น Full Cycles
                      ],
                    ),
                  ),
                ),

                // --- 3. Done Button (ตกตำแหน่งเดียวกับ Complete Session แน่นอน) ---
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: primaryGreen.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5)),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lang.translate('cpr', 'done'),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF10B981), size: 28),
        const SizedBox(width: 15),
        Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
