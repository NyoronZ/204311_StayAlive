import 'package:flutter/material.dart';
import 'cpr_timer_screen.dart';
// import 'package:url_launcher/url_launcher.dart'; // ต้องลง package นี้สำหรับการโทร

class CprPrepGuideScreen extends StatefulWidget {
  final String ageGroup;
  final bool callEmergency;

  const CprPrepGuideScreen(
      {super.key, required this.ageGroup, required this.callEmergency});

  @override
  State<CprPrepGuideScreen> createState() => _CprPrepGuideScreenState();
}

class _CprPrepGuideScreenState extends State<CprPrepGuideScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.callEmergency) {
      _makeEmergencyCall();
    }
  }

  Future<void> _makeEmergencyCall() async {
    // TODO: ใส่ Logic โทรออกเบื้องหลัง เช่น launchUrl(Uri.parse('tel:1669'));
    debugPrint("Calling 1669 in background...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Remember")),
      body: Column(
        children: [
          Text("Preparation for ${widget.ageGroup}"), // แสดงเนื้อหาตาม ageGroup
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CprTimerScreen(ageGroup: widget.ageGroup),
                ),
              );
            },
            child: const Text("START CPR"),
          )
        ],
      ),
    );
  }
}
