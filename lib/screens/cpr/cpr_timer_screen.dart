import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import 'cpr_success_screen.dart';
import '../../components/shadow_card.dart';

enum CprPhase { ready, countdown, compressing, breathing }

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

  final AudioPlayer _audioPlayer = AudioPlayer();

  CprPhase currentPhase = CprPhase.ready;
  int cycle = 1;
  int compressions = 0;
  final int compressionsPerCycle = 30;

  Timer? _timer;
  Timer? _overallTimer;
  Timer? _countdownTimer;
  int totalSecondsElapsed = 0;
  int countdownTicks = 3;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer?.cancel();
    _overallTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      currentPhase = CprPhase.countdown;
      countdownTicks = 3;
    });
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownTicks--;
        if (countdownTicks <= 0) {
          timer.cancel();
          _startCompressions();
        }
      });
    });
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
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      await _audioPlayer.stop();
      _audioPlayer.play(AssetSource('audio/beep.mp3'));
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
    if (currentPhase == CprPhase.countdown) return orangeColor;
    if (currentPhase == CprPhase.compressing) return primaryGreen;
    return greyColor;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    int secondsRemaining = 15 - (compressions ~/ 2);
    if (currentPhase == CprPhase.ready || currentPhase == CprPhase.countdown)
      secondsRemaining = 15;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
          child: Column(
            children: [
              // --- 1. Content Area (Expanded ช่วยป้องกัน Overflow ถาวร) ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildTimerCircle(secondsRemaining),
                      const SizedBox(height: 35),

                      // 🌟 ส่วน Information เอา ShadowCard ออกตามที่คุณชอบ (คงความสูงไว้ 65px)
                      SizedBox(
                        height: 65,
                        child: Center(
                          child: currentPhase == CprPhase.breathing
                              ? Text(lang.translate('cpr', 'give_breaths'),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: primaryGreen))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(lang.translate('cpr', 'push_depth'),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54)),
                                    const SizedBox(height: 4),
                                    Text(_getDepthInfo(lang),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87)),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // 🌟 ส่วน Progress Bar คง ShadowCard ไว้
                      Visibility(
                        visible: currentPhase != CprPhase.ready &&
                            currentPhase != CprPhase.countdown,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: ShadowCard(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${lang.translate('cpr', 'compressions')}: $compressions/30",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                    Text(
                                        "${lang.translate('cpr', 'cycle')} $cycle",
                                        style: TextStyle(
                                            color: primaryGreen,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ],
                                ),
                                const SizedBox(height: 10),
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
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    "${30 - compressions} ${lang.translate('cpr', 'until_breath')}",
                                    style: const TextStyle(
                                        fontSize: 11, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // --- 2. Locked Button Area (ความสูงคงที่ 140px ล็อกปุ่มไว้ด้านล่างเสมอ) ---
              SizedBox(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentPhase == CprPhase.ready)
                      _buildActionButton(
                          title: lang.translate('cpr', 'start_cpr'),
                          color: buttonRed,
                          icon: Icons.play_arrow,
                          onTap: _startCountdown)
                    else if (currentPhase == CprPhase.countdown)
                      _buildActionButton(
                          title: lang.translate('cpr', 'get_ready'),
                          color: orangeColor,
                          icon: Icons.timer,
                          onTap: () {})
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
                          _startCountdown();
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
                          _countdownTimer?.cancel();
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
                                totalCycles: finalCycles,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
          children: currentPhase == CprPhase.countdown
              ? [
                  Text("$countdownTicks",
                      style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: themeCol,
                          height: 1.1))
                ]
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: themeCol, size: 50),
                      const SizedBox(width: 5),
                      const Text("120",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              height: 1.1)),
                    ],
                  ),
                  Text(timeString,
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          height: 1.1)),
                ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      {required String title,
      required Color color,
      required IconData? icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 8)
            ],
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
