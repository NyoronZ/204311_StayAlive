import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class QuickTestScreen extends StatelessWidget {
  const QuickTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Quick Test"),
      body: Center(child: Text("Quick Test Page Content")),
    );
  }
}