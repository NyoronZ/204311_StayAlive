import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class FindHospitalScreen extends StatelessWidget {
  const FindHospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Find Hospital"),
      body: Center(child: Text("Find Hospital Page Content")),
    );
  }
}