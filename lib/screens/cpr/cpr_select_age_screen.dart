import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/shadow_card.dart';
import 'cpr_prep_guide_screen.dart'; // อย่าลืม import หน้าถัดไป

class CprSelectAgeScreen extends StatefulWidget {
  const CprSelectAgeScreen({super.key});

  @override
  State<CprSelectAgeScreen> createState() => _CprSelectAgeScreenState();
}

class _CprSelectAgeScreenState extends State<CprSelectAgeScreen> {
  String selectedAge = 'Infant';
  bool isEmergencyCall = true;

  final Color primaryGreen = const Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    double textScaleRatio = MediaQuery.of(context).size.width / 375.0;

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
            height: 600, // ล็อกความสูงกรอบเขียว
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryGreen, width: 2),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // แยกเนื้อหาบน-ล่าง
              children: [
                // --- Group 1: Header + การ์ดเลือกอายุ ---
                Column(
                  children: [
                    // --- Header ---
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.priority_high,
                                color: primaryGreen, size: 24),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            lang.translate('cpr', 'select_age_title'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    // --- Cards ---
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ShadowCard(
                            title: lang.translate('cpr', 'infant'),
                            subtitle: lang.translate('cpr', 'infant_sub'),
                            color: const Color(0xFFBFF6C3),
                            emoji: '👶',
                            textScaleRatio: textScaleRatio,
                            isSelected: selectedAge == 'Infant',
                            onTap: () => setState(() => selectedAge = 'Infant'),
                          ),
                          const SizedBox(height: 15),
                          ShadowCard(
                            title: lang.translate('cpr', 'child'),
                            subtitle: lang.translate('cpr', 'child_sub'),
                            color: const Color(0xFFC4E4FF),
                            emoji: '👦',
                            textScaleRatio: textScaleRatio,
                            isSelected: selectedAge == 'Child',
                            onTap: () => setState(() => selectedAge = 'Child'),
                          ),
                          const SizedBox(height: 15),
                          ShadowCard(
                            title: lang.translate('cpr', 'adult'),
                            subtitle: lang.translate('cpr', 'adult_sub'),
                            color: const Color(0xFFFFE4C4),
                            emoji: '👨',
                            textScaleRatio: textScaleRatio,
                            isSelected: selectedAge == 'Adult',
                            onTap: () => setState(() => selectedAge = 'Adult'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // --- Group 2: Checkbox + ปุ่ม Next Step ---
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    children: [
                      // --- Checkbox ---
                      GestureDetector(
                        onTap: () =>
                            setState(() => isEmergencyCall = !isEmergencyCall),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4)),
                            ],
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isEmergencyCall
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: isEmergencyCall
                                    ? primaryGreen
                                    : Colors.grey.shade600,
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Text(lang.translate('cpr', 'emergency_call'),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // --- Next Button ---
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CprPrepGuideScreen(
                                ageGroup: selectedAge,
                                callEmergency: isEmergencyCall,
                              ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_arrow,
                                  color: Colors.white, size: 28),
                              const SizedBox(width: 8),
                              Text(lang.translate('cpr', 'next_step'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
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
