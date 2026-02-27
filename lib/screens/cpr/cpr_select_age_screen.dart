import 'package:flutter/material.dart';
import 'cpr_prep_guide_screen.dart';

class CprSelectAgeScreen extends StatefulWidget {
  const CprSelectAgeScreen({super.key});

  @override
  State<CprSelectAgeScreen> createState() => _CprSelectAgeScreenState();
}

class _CprSelectAgeScreenState extends State<CprSelectAgeScreen> {
  String selectedAge = 'Infant'; // Default
  bool isEmergencyCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Patient Age")),
      body: Column(
        children: [
          // TODO: ใส่ UI ปุ่มเลือกอายุ (Infant, Child, Adult) ตรงนี้

          CheckboxListTile(
            title: const Text("Emergency call"),
            value: isEmergencyCall,
            onChanged: (val) => setState(() => isEmergencyCall = val ?? false),
          ),
          ElevatedButton(
            onPressed: () {
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
            child: const Text("Next Step"),
          )
        ],
      ),
    );
  }
}
