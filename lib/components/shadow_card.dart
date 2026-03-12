import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color color;
  final String? emoji;
  final double? textScaleRatio;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? child; // รับ Widget เข้ามาแสดง

  const ShadowCard({
    super.key,
    this.title,
    this.subtitle,
    required this.color,
    this.emoji,
    this.textScaleRatio,
    this.isSelected = false,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: const Color(0xFF10B981), width: 2)
              : Border.all(color: Colors.transparent, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // เช็คว่าถ้ามี title ค่อยแสดงส่วน Header
            if (title != null && emoji != null && subtitle != null)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white24
                              : Colors.black12),
                    ),
                    child: Text(emoji!,
                        style:
                            TextStyle(fontSize: 24 * (textScaleRatio ?? 1.0))),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                              fontSize: 18 * (textScaleRatio ?? 1.0),
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text(
                          subtitle!,
                          style: TextStyle(
                              fontSize: 14 * (textScaleRatio ?? 1.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white70
                                  : Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            // แสดงเนื้อหาที่ส่งเข้ามา (Checklist)
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
