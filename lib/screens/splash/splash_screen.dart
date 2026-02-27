import 'package:flutter/material.dart';
import 'dart:async';
import '../home/home_screen.dart';
import '../tutorial/tutorial.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // รอให้ Widget โครงสร้างพื้นฐานพร้อมก่อน แล้วค่อยโหลด
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadComponents();
    });
  }

  Future<void> _loadComponents() async {
    // 1. รอโหลดทุกอย่างให้เสร็จตรงนี้ (await) และรออย่างน้อย 1 วินาที
    await Future.wait([
      precacheImage(
          const AssetImage('assets/images/stayalive_logo.png'), context),
      Future.delayed(const Duration(seconds: 1)),
    ]);

    // 2. ป้องกัน Error ถ้าหน้า Loading ถูกปิดไปแล้ว
    if (!mounted) return;

    // 3. โหลดเสร็จทั้งหมด ค่อยไปหน้า HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF10B981),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // heart icon
            Icon(Icons.favorite, size: 120, color: Colors.white),
            SizedBox(height: 60),
            // loading spinner
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
