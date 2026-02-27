import 'package:flutter/material.dart';
import 'dart:async';
import 'cpr_success_screen.dart';

class CprTimerScreen extends StatefulWidget {
  final String ageGroup;
  const CprTimerScreen({super.key, required this.ageGroup});

  @override
  State<CprTimerScreen> createState() => _CprTimerScreenState();
}

class _CprTimerScreenState extends State<CprTimerScreen> {
  // ตั้งค่าสีตามภาพ
  final Color darkRed = const Color(0xFF9E2A2B); // สีแดงเข้มขอบวงกลม
  final Color lightPink = const Color(0xFFFFF0F0); // สีพื้นหลัง Push Depth
  final Color buttonRed = const Color(0xFFDE6464); // สีปุ่มแดง

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- วงกลมแดง ---
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: darkRed, width: 12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite,
                            color: darkRed, size: 50), // ไอคอนหัวใจ
                        const SizedBox(width: 5),
                        const Text(
                          "120",
                          style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                              height: 1.1),
                        ),
                      ],
                    ),
                    const Text(
                      "1:00",
                      style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // --- Push Depth Box ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: lightPink,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    const Text("Push Depth",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    // เปลี่ยนคำว่า Baby ตาม ageGroup ได้
                    Text("${widget.ageGroup}: ~4 cm",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- START CPR Button ---
              GestureDetector(
                onTap: () {
                  // TODO: เปลี่ยน State เข้าสู่โหมดวงกลมสีเขียว (เริ่มจับเวลา)
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: buttonRed,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: buttonRed.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 5)),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 28),
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
    );
  }
}
