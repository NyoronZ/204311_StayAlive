import 'package:flutter/material.dart';

// --- 1. ตัวครอบ (Wrapper) สำหรับจัดการ Logic ป้องกันการสั่นและเปลี่ยนหน้า ---
class ScrollNavigatorWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onNavigate;

  const ScrollNavigatorWrapper({
    super.key,
    required this.child,
    required this.onNavigate,
  });

  @override
  State<ScrollNavigatorWrapper> createState() => _ScrollNavigatorWrapperState();
}

class _ScrollNavigatorWrapperState extends State<ScrollNavigatorWrapper> {
  bool _isNavigating = false; // ตัวแปรล็อคสถานะ ป้องกันการรันคำสั่งซ้ำ

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        // ถ้าเลื่อนเกิน 60 pixel และ *ยังไม่ได้กำลังเปลี่ยนหน้า*
        if (!_isNavigating &&
            notification.metrics.pixels >
                notification.metrics.maxScrollExtent + 60) {
          _isNavigating = true; // ล็อคทันทีไม่ให้ทำซ้ำ (แก้หน้าจอสั่น 100%)
          widget.onNavigate();
          return true;
        }

        // คืนค่าสถานะเมื่อผู้ใช้ปล่อยมือแล้วเด้งกลับมา (เผื่อกดย้อนกลับมาหน้านี้อีก)
        if (_isNavigating &&
            notification.metrics.pixels <=
                notification.metrics.maxScrollExtent) {
          _isNavigating = false;
        }

        return false;
      },
      child: widget.child,
    );
  }
}

// --- 2. ตัว UI ข้อความ + ลูกศร ด้านล่างสุด ---
class ScrollDownIndicator extends StatelessWidget {
  final String text;

  const ScrollDownIndicator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white70 : Colors.black87;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
        const SizedBox(height: 8),
        Icon(Icons.keyboard_double_arrow_down, size: 40, color: color),
        const SizedBox(height: 20),
      ],
    );
  }
}
