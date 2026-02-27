import 'package:flutter/material.dart';
import '../../components/shadow_card.dart';
import 'cpr_timer_screen.dart'; // เตรียมไว้สำหรับหน้าถัดไป

class CprPrepGuideScreen extends StatefulWidget {
  final String ageGroup;
  final bool callEmergency;

  const CprPrepGuideScreen({
    super.key,
    required this.ageGroup,
    required this.callEmergency,
  });

  @override
  State<CprPrepGuideScreen> createState() => _CprPrepGuideScreenState();
}

class _CprPrepGuideScreenState extends State<CprPrepGuideScreen> {
  final Color primaryGreen = const Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    if (widget.callEmergency) {
      // TODO: ใส่ฟังก์ชันโทรฉุกเฉินอัตโนมัติเบื้องหลังตรงนี้
      debugPrint("Calling Emergency...");
    }
  }

  // กำหนดเนื้อหาตามช่วงอายุ
  Map<String, dynamic> _getAgeData(String age) {
    switch (age) {
      case 'Infant':
        return {
          'emoji': '👶',
          'color': const Color(0xFFBFF6C3),
          'title': 'Rescue Breaths',
          'subtitle': 'Give 2 small breaths, when heard a signal',
          'checks': [
            'Place 2 fingers just below nipple line',
            'Use 1 or 2 hands depending on child size',
            'Compress at least 1.5 inches or 3 centimeters deep',
          ],
        };
      case 'Child':
        return {
          'emoji': '👦',
          'color': const Color(0xFFC4E4FF),
          'title': 'Rescue Breaths',
          'subtitle': 'Give 2 breaths, when heard a signal',
          'checks': [
            'Place heel of 1 or 2 hands on center of chest',
            'Compress about 2 inches or 5 centimeters deep',
            'Push hard and fast',
          ],
        };
      case 'Adult':
      default:
        return {
          'emoji': '👨',
          'color': const Color(0xFFFFE4C4),
          'title': 'Rescue Breaths',
          'subtitle': 'Give 2 breaths, when heard a signal',
          'checks': [
            'Place heel of 2 hands on center of chest',
            'Compress at least 2 inches or 5 centimeters deep',
            'Push hard and fast',
          ],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    double textScaleRatio = MediaQuery.of(context).size.width / 375.0;
    final ageData = _getAgeData(widget.ageGroup);

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
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 600, // ล็อกความสูงกรอบทั้งหมดไว้ที่นี่
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryGreen, width: 2),
            ),
            child: Column(
              children: [
                // --- Header (สีเขียว) ---
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(Icons.priority_high,
                            color: primaryGreen, size: 24),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "Remember",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // --- Body ---
                Expanded(
                  // ใช้ Expanded เพื่อกินพื้นที่ความสูงที่เหลือจาก 650
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // ดันเนื้อหาขึ้นบน ดันปุ่มลงล่าง
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Group 1: เนื้อหาและ Checklist ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Emoji Circle
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: ageData['color'],
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: primaryGreen, width: 3),
                              ),
                              alignment: Alignment.center,
                              child: Text(ageData['emoji'],
                                  style:
                                      TextStyle(fontSize: 35 * textScaleRatio)),
                            ),
                            const SizedBox(height: 15),

                            // Texts
                            Text(
                              ageData['title'],
                              style: TextStyle(
                                  fontSize: 18 * textScaleRatio,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              ageData['subtitle'],
                              style: TextStyle(
                                  fontSize: 14 * textScaleRatio,
                                  color: Colors.black87),
                            ),
                            const SizedBox(height: 20),

                            // Check List Box (ใช้ ShadowCard)
                            ShadowCard(
                              color: const Color(0xFFC6F6D5),
                              child: Column(
                                children: (ageData['checks'] as List<String>)
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
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                                fontSize: 16 * textScaleRatio,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),

                        // --- Group 2: ปุ่ม START CPR ---
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CprTimerScreen(ageGroup: widget.ageGroup),
                              ),
                            );
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_arrow,
                                    color: Colors.white, size: 28),
                                SizedBox(width: 8),
                                Text(
                                  "START CPR",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
}
