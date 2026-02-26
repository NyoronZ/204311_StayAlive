import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class QuickGuideScreen extends StatelessWidget {
  const QuickGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Quick Guide"),
      body: Center(child: Text("Quick Guide Page Content")),
    );
  }
}