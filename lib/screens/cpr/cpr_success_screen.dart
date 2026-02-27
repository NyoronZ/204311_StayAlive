import 'package:flutter/material.dart';

class CprSuccessScreen extends StatelessWidget {
  final String ageGroup;
  final int timeElapsed;
  final int cycles;

  const CprSuccessScreen(
      {super.key,
      required this.ageGroup,
      required this.timeElapsed,
      required this.cycles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.green,
                child: Text("Success!",
                    style: TextStyle(color: Colors.white, fontSize: 30))),
            const SizedBox(height: 20),
            Text("Age: $ageGroup"),
            Text("Time: ${timeElapsed}s"),
            Text("Cycles: $cycles"),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/home')),
              child: const Text("Done"),
            )
          ],
        ),
      ),
    );
  }
}
