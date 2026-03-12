import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/shadow_card.dart';
import '../../components/custom_app_bar.dart';

class CprSuccessScreen extends StatelessWidget {
  final String ageGroup;
  final int totalTimeInSeconds;
  final int totalCompressions;
  final int totalCycles;

  const CprSuccessScreen(
      {super.key,
      required this.ageGroup,
      required this.totalTimeInSeconds,
      required this.totalCompressions,
      required this.totalCycles});

  String get formattedTime {
    int minutes = totalTimeInSeconds ~/ 60;
    int seconds = totalTimeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final Color primaryGreen = const Color(0xFF10B981);
    final Color lightGreen = const Color.fromARGB(255, 221, 255, 232);

    return Scaffold(
      appBar: CustomAppBar(
        title: lang.translate('cpr', 'success_title'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // --- ป้องกัน Overflow และขอบตัดด้วย Expanded + Padding ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5), // ป้องกันเงา ShadowCard โดนตัดขอบ
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: primaryGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: primaryGreen.withValues(alpha: 0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: Colors.white, size: 60),
                            const SizedBox(height: 10),
                            Text(lang.translate('cpr', 'success'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      ShadowCard(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? primaryGreen.withOpacity(0.1)
                            : lightGreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 25),
                          child: Column(
                            children: [
                              _buildStatRow(Icons.speed,
                                  lang.translate('cpr', 'speed'), "120 BPM"),
                              const SizedBox(height: 16),
                              _buildStatRow(
                                  Icons.person_outline,
                                  lang.translate('cpr', 'age'),
                                  lang.translate(
                                      'cpr', ageGroup.toLowerCase())),
                              const SizedBox(height: 16),
                              _buildStatRow(Icons.timer_outlined,
                                  lang.translate('cpr', 'time'), formattedTime),
                              const SizedBox(height: 16),
                              _buildStatRow(
                                  Icons.monitor_heart_outlined,
                                  lang
                                      .translate('cpr', 'compressions')
                                      .replaceAll(':', '')
                                      .trim(),
                                  "$totalCompressions"),
                              const SizedBox(height: 16),
                              _buildStatRow(
                                  Icons.autorenew,
                                  lang.translate('cpr', 'full_cycles'),
                                  "$totalCycles"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // --- ตำแหน่ง Done ตั้งศูนย์ให้ตรงกับ Complete Session ขาดตัว ---
              const SizedBox(height: 15),
              const SizedBox(
                  height: 30), // ช่องว่างจำลองของปุ่ม Action หน้า Timer
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: primaryGreen.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  alignment: Alignment.center,
                  child: Text(lang.translate('cpr', 'done'),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF10B981), size: 26),
        const SizedBox(width: 15),
        Text(label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
