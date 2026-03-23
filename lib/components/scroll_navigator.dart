/*
 * File: scroll_navigator.dart
 * Description: Provides a wrapper and UI indicators for scroll-to-navigate functionality.
 *
 * Dependencies:
 * - Flutter Material library
 *
 * Lifecycle:
 * - Created dynamically within scrollable views
 * - Disposed when the parent view is removed
 *
 * Responsibilities:
 * - Listens to scroll events to trigger navigation on overscroll
 * - Prevents duplicate navigation triggers during rapid scrolling
 *
 * Author: Kitichai Fanprom
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';

/// A wrapper that handles overscroll logic to prevent jitter and duplicate navigation.
class ScrollNavigatorWrapper extends StatefulWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// The callback to execute when the overscroll threshold is reached.
  final VoidCallback onNavigate;

  /// Creates a [ScrollNavigatorWrapper] with the given child and navigation callback.
  const ScrollNavigatorWrapper({
    super.key,
    required this.child,
    required this.onNavigate,
  });

  @override
  State<ScrollNavigatorWrapper> createState() => _ScrollNavigatorWrapperState();
}

class _ScrollNavigatorWrapperState extends State<ScrollNavigatorWrapper> {
  // Locks the state to prevent duplicate executions.
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        // If scrolled past 60 pixels beyond the maximum extent and not currently navigating.
        if (!_isNavigating &&
            notification.metrics.pixels >
                notification.metrics.maxScrollExtent + 60) {
          // Lock immediately to prevent duplicate triggers (prevents screen jittering 100%).
          _isNavigating = true; 
          widget.onNavigate();
          return true;
        }

        // Reset the state when the user releases and the scroll view bounces back.
        // This ensures the trigger works again if the user returns to this screen.
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

/// A visual indicator displaying text and a downward arrow at the bottom of the screen.
class ScrollDownIndicator extends StatelessWidget {
  /// The text displayed above the arrow icon.
  final String text;

  /// Creates a [ScrollDownIndicator] with the specified text.
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