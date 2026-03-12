import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/shadow_card.dart';
import 'cpr_timer_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/custom_app_bar.dart';

class CprPrepGuideScreen extends StatefulWidget {
  final String ageGroup;
  final bool callEmergency;

  const CprPrepGuideScreen(
      {super.key, required this.ageGroup, required this.callEmergency});

  @override
  State<CprPrepGuideScreen> createState() => _CprPrepGuideScreenState();
}

class _CprPrepGuideScreenState extends State<CprPrepGuideScreen> {
  final Color primaryGreen = const Color(0xFF10B981);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri.parse("tel:$phoneNumber");
    try {
      if (!await launchUrl(launchUri))
        throw Exception('Could not launch $launchUri');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.callEmergency) _makePhoneCall('0000');
  }

  Map<String, dynamic> _getAgeData(LanguageProvider lang, String age) {
    switch (age) {
      case 'Infant':
        return {
          'emoji': '👶',
          'color': const Color(0xFFBFF6C3),
          'title': lang.translate('cpr', 'rescue_breaths'),
          'subtitle': lang.translate('cpr', 'prep_infant_sub'),
          'checks': [
            lang.translate('cpr', 'prep_infant_ch1'),
            lang.translate('cpr', 'prep_infant_ch2'),
            lang.translate('cpr', 'prep_infant_ch3')
          ],
          'darkColor': const Color(0xFF1E3A24),
        };
      case 'Child':
        return {
          'emoji': '👦',
          'color': const Color(0xFFC4E4FF),
          'title': lang.translate('cpr', 'rescue_breaths'),
          'subtitle': lang.translate('cpr', 'prep_child_sub'),
          'checks': [
            lang.translate('cpr', 'prep_child_ch1'),
            lang.translate('cpr', 'prep_child_ch2'),
            lang.translate('cpr', 'prep_child_ch3')
          ],
          'darkColor': const Color(0xFF1E2E3D),
        };
      case 'Adult':
      default:
        return {
          'emoji': '👨',
          'color': const Color(0xFFFFE4C4),
          'title': lang.translate('cpr', 'rescue_breaths'),
          'subtitle': lang.translate('cpr', 'prep_adult_sub'),
          'checks': [
            lang.translate('cpr', 'prep_adult_ch1'),
            lang.translate('cpr', 'prep_adult_ch2'),
            lang.translate('cpr', 'prep_adult_ch3')
          ],
          'darkColor': const Color(0xFF3D2E1E),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final brightness = Theme.of(context).brightness;
    double textScaleRatio = MediaQuery.of(context).size.width / 375.0;
    final ageData = _getAgeData(lang, widget.ageGroup);

    return Scaffold(
      appBar: CustomAppBar(
        title: lang.translate('cpr', 'cpr_title'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryGreen, width: 2)),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                            color: primaryGreen,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18))),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.white,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.priority_high,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : primaryGreen,
                                    size: 24)),
                            const SizedBox(width: 15),
                            Text(lang.translate('cpr', 'remember'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      // Checklist (เลื่อนได้ ป้องกัน Overflow)
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ageData['darkColor']
                                        : ageData['color'],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: primaryGreen, width: 3)),
                                alignment: Alignment.center,
                                child: Text(ageData['emoji'],
                                    style: TextStyle(
                                        fontSize: 35 * textScaleRatio)),
                              ),
                              const SizedBox(height: 15),
                              Text(ageData['title'],
                                  style: TextStyle(
                                      fontSize: 18 * textScaleRatio,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(ageData['subtitle'],
                                  style: TextStyle(
                                      fontSize: 14 * textScaleRatio,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                              const SizedBox(height: 20),
                              ShadowCard(
                                color: brightness == Brightness.dark
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFFC6F6D5),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children:
                                        (ageData['checks'] as List<String>)
                                            .map((text) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.check_circle_outline,
                                                color: primaryGreen, size: 22),
                                            const SizedBox(width: 10),
                                            Expanded(
                                                child: Text(text,
                                                    style: TextStyle(
                                                        fontSize: 15 *
                                                            textScaleRatio))),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ปุ่ม START CPR (กลับเข้ากล่องแล้ว)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 20.0),
                        child: _buildActionButton(
                          title: lang.translate('cpr', 'start_cpr'),
                          color: primaryGreen,
                          icon: Icons.play_arrow,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CprTimerScreen(
                                        ageGroup: widget.ageGroup)));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 🌟 เว้นระยะ 53px เพื่อตั้งศูนย์ให้ตรงกับหน้า Timer
              const SizedBox(height: 53),
            ],
          ),
        ),
      ),
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
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ]),
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
