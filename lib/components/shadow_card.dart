/*
 * File: shadow_card.dart
 * Description: A reusable card widget with a shadow, border, and optional header.
 *
 * Dependencies:
 * - Flutter Material library
 *
 * Lifecycle:
 * - Created via parent UI elements
 * - Disposed when the parent view is removed
 *
 * Responsibilities:
 * - Displays content with a styled background, shadow, and selection state
 * - Optionally renders a header containing an emoji, title, and subtitle
 *
 * Author: Kitichai Fanprom
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';

/// A custom card widget that provides a stylized container with an optional header and child content.
class ShadowCard extends StatelessWidget {
  /// The primary title displayed in the header.
  final String? title;

  /// The secondary text displayed below the title.
  final String? subtitle;

  /// The background color of the card.
  final Color color;

  /// The emoji character displayed in the header icon.
  final String? emoji;

  /// The scaling factor for text elements inside the header.
  final double? textScaleRatio;

  /// Whether the card is currently selected, which applies a highlighted border.
  final bool isSelected;

  /// The callback executed when the card is tapped.
  final VoidCallback? onTap;

  /// The widget displayed below the header inside the card body.
  final Widget? child;

  /// Creates a [ShadowCard] with the given styling and content.
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
            // Render the header if all header elements are provided.
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
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
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
            // Display the provided child content (e.g., a checklist).
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
