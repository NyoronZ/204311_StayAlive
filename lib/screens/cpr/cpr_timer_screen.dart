import 'package:flutter/material.dart';
import 'dart:async';
import 'cpr_success_screen.dart';

enum CprPhase { ready, compressions, breaths }

class CprTimerScreen extends StatefulWidget {
  final String ageGroup;
  const CprTimerScreen({super.key, required this.ageGroup});

  @override
  State<CprTimerScreen> createState() => _CprTimerScreenState();
}

class _CprTimerScreenState extends State<CprTimerScreen> {
  CprPhase currentPhase = CprPhase.ready;
  int cyclesCompleted = 0;
  int secondsElapsed = 0;
  Timer? _timer;

  void startCpr() {
    setState(() => currentPhase = CprPhase.compressions);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => secondsElapsed++);
      // TODO: ใส่ Logic นับจำนวนครั้งปั๊มหัวใจ เพื่อเปลี่ยนเป็น Phase.breaths
    });
  }

  void completeSession() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CprSuccessScreen(
          ageGroup: widget.ageGroup,
          timeElapsed: secondsElapsed,
          cycles: cyclesCompleted,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CPR Progress")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // วงกลมเปลี่ยนสีตาม Phase
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: currentPhase == CprPhase.ready
                      ? Colors.red
                      : currentPhase == CprPhase.compressions
                          ? Colors.green
                          : Colors.grey,
                  width: 10,
                ),
              ),
              child: Center(
                  child: Text("120\n${secondsElapsed}s",
                      textAlign: TextAlign.center)),
            ),

            // ปุ่ม Action หลัก
            if (currentPhase == CprPhase.ready)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: startCpr,
                  child: const Text("START CPR"))
            else if (currentPhase == CprPhase.compressions)
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => setState(
                      () => currentPhase = CprPhase.breaths), // จำลองข้าม Phase
                  child: const Text("CPR in progress"))
            else
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    setState(() {
                      cyclesCompleted++;
                      currentPhase = CprPhase.compressions; // กลับไปปั๊มต่อ
                    });
                  },
                  child: const Text("Continue (Breaths Done)")),

            // ปุ่มจบการทำงาน
            if (currentPhase != CprPhase.ready)
              TextButton(
                  onPressed: completeSession,
                  child: const Text("Complete Session"))
          ],
        ),
      ),
    );
  }
}
