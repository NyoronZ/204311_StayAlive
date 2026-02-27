import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import 'dart:async';
import 'cpr_success_screen.dart';
import '../../components/shadow_card.dart';

enum CprPhase { ready, compressing, breathing }

class CprTimerScreen extends StatefulWidget {
  final String ageGroup;
  const CprTimerScreen({super.key, required this.ageGroup});

  @override
  State<CprTimerScreen> createState() => _CprTimerScreenState();
}

class _CprTimerScreenState extends State<CprTimerScreen> {
  final Color darkRed = const Color(0xFF9E2A2B);
  final Color buttonRed = const Color(0xFFDE6464);
  final Color primaryGreen = const Color(0xFF10B981);
  final Color greyColor = const Color(0xFF8A9A8B);
  final Color orangeColor = const Color(0xFFF6A030);
  final Color lightGrey = const Color(0xFFE2E8F0);

  CprPhase currentPhase = CprPhase.ready;
  int cycle = 1;
  int compressions = 0;
  final int compressionsPerCycle = 30;

  Timer? _timer;
  Timer? _overallTimer;
  int totalSecondsElapsed = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _overallTimer?.cancel();
    super.dispose();
  }

  void _startCompressions() {
    _overallTimer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => totalSecondsElapsed++);
    });

    setState(() {
      currentPhase = CprPhase.compressing;
      compressions = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      // TODO: ใส่เสียง Beep ตรงนี้
      debugPrint("BEEP!");

      setState(() {
        compressions++;
        if (compressions >= compressionsPerCycle) {
          timer.cancel();
          currentPhase = CprPhase.breathing;
        }
      });
    });
  }

  String _getDepthInfo(LanguageProvider lang) {
    if (widget.ageGroup == 'Infant')
      return lang.translate('cpr', 'depth_infant');
    if (widget.ageGroup == 'Child') return lang.translate('cpr', 'depth_child');
    return lang.translate('cpr', 'depth_adult');
  }

  Color _getThemeColor() {
    if (currentPhase == CprPhase.ready) return darkRed;
    if (currentPhase == CprPhase.compressing) return primaryGreen;
    return greyColor;
  }

  Color _getCardColor() {
    if (currentPhase == CprPhase.ready) return const Color(0xFFFFF0F0);
    if (currentPhase == CprPhase.compressing) return const Color(0xFFC6F6D5);
    return const Color(0xFFF1F5F9);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    int secondsRemaining = 15 - (compressions ~/ 2);
    if (currentPhase == CprPhase.ready) secondsRemaining = 15;
    if (currentPhase == CprPhase.breathing) secondsRemaining = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: SizedBox(
            height: 680, // 👈 ล็อกความสูงรวมของหน้าจอ
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // 👈 ดัน 3 กรุ๊ปให้ห่างกันพอดี
              children: [
                // --- Group 1: Timer ---
                _buildTimerCircle(secondsRemaining),

                // --- Group 2: Information & Progress ---
                Column(
                  children: [
                    ShadowCard(
                      color: _getCardColor(),
                      child: SizedBox(
                        height:
                            60, // 👈 ล็อกความสูงของการ์ดนี้ ไม่ให้หดตัวเวลาเหลือบรรทัดเดียว
                        child: Center(
                          child: currentPhase == CprPhase.breathing
                              ? Text(lang.translate('cpr', 'give_breaths'),
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(lang.translate('cpr', 'push_depth'),
                                        style: TextStyle(
                                            fontSize: lang.currentLocale
                                                        .languageCode ==
                                                    'th'
                                                ? 18
                                                : 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(_getDepthInfo(lang),
                                        style: TextStyle(
                                            fontSize: lang.currentLocale
                                                        .languageCode ==
                                                    'th'
                                                ? 20
                                                : 22,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: currentPhase != CprPhase.ready,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: ShadowCard(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${lang.translate('cpr', 'compressions')} $compressions/30",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Text(
                                      "${lang.translate('cpr', 'cycle')} $cycle",
                                      style: TextStyle(
                                          color: primaryGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: compressions / 30,
                                  backgroundColor: lightGrey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryGreen),
                                  minHeight: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  "${30 - compressions} ${lang.translate('cpr', 'until_breath')}",
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // --- Group 3: Buttons ---
                Column(
                  children: [
                    if (currentPhase == CprPhase.ready)
                      _buildActionButton(
                          title: lang.translate('cpr', 'start_cpr'),
                          color: buttonRed,
                          icon: Icons.play_arrow,
                          onTap: _startCompressions)
                    else if (currentPhase == CprPhase.compressing)
                      _buildActionButton(
                          title: lang.translate('cpr', 'cpr_in_progress'),
                          color: primaryGreen,
                          icon: Icons.favorite,
                          onTap: () {})
                    else if (currentPhase == CprPhase.breathing)
                      _buildActionButton(
                        title: lang.translate('cpr', 'continue_btn'),
                        color: orangeColor,
                        icon: Icons.play_arrow,
                        onTap: () {
                          setState(() => cycle++);
                          _startCompressions();
                        },
                      ),
                    const SizedBox(height: 15),
                    Visibility(
                      visible: currentPhase != CprPhase.ready,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: _buildActionButton(
                        title: lang.translate('cpr', 'complete_session'),
                        color: const Color(0xFF4A554C),
                        icon: null,
                        onTap: () {
                          _timer?.cancel();
                          _overallTimer?.cancel();

                          // 👈 เพิ่มลอจิก "เชื่อใจ": ถ้าอยู่หน้าเป่าปากให้นับรอบนั้นเป็นรอบสมบูรณ์เลย
                          int finalCycles = (currentPhase == CprPhase.breathing)
                              ? cycle
                              : cycle - 1;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CprSuccessScreen(
                                ageGroup: widget.ageGroup,
                                totalTimeInSeconds: totalSecondsElapsed,
                                totalCompressions:
                                    ((cycle - 1) * 30) + compressions,
                                totalCycles:
                                    finalCycles, // 👈 ใช้ตัวแปรที่คำนวณใหม่
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerCircle(int secondsRemaining) {
    Color themeCol = _getThemeColor();
    String timeString = "0:${secondsRemaining.toString().padLeft(2, '0')}";

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: currentPhase == CprPhase.compressing
                ? (compressions / 30)
                : 1.0,
            strokeWidth: 12,
            backgroundColor: lightGrey,
            valueColor: AlwaysStoppedAnimation<Color>(themeCol),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monitor_heart, color: themeCol, size: 50),
                const SizedBox(width: 5),
                const Text(
                  "120",
                  style: TextStyle(
                      fontSize: 60, fontWeight: FontWeight.bold, height: 1.1),
                ),
              ],
            ),
            Text(
              timeString,
              style: const TextStyle(
                  fontSize: 50, fontWeight: FontWeight.bold, height: 1.1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required Color color,
    required IconData? icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
