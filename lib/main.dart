import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const StayAliveApp());
}

class StayAliveApp extends StatelessWidget {
  const StayAliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stay Alive',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF10B981), 
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoadingScreen(),
    );
  }
}