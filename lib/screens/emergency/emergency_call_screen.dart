import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class EmergencyCallScreen extends StatelessWidget {
  const EmergencyCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Emergency Call"),
      body: Center(child: Text("Emergency Call Page Content")),
    );
  }
}