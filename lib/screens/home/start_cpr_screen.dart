import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class StartCprScreen extends StatelessWidget {
  const StartCprScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Start CPR"),
      body: Center(child: Text("Start CPR Page Content")),
    );
  }
}