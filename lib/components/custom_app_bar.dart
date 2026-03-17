/*
 * File: custom_app_bar.dart
 * Description: Defines a reusable CustomAppBar widget that provides a consistent
 *              top navigation bar with a back button and a centered title across the application.
 *
 * Responsibilities:
 * - Displays a customizable title in the AppBar
 * - Provides back navigation using Navigator.pop
 * - Maintains consistent UI design across screens
 *
 * Author: Rattanun Deewongsai / Stayalive
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';

/// A reusable custom AppBar widget with a back button and centered title.
///
/// This widget implements [PreferredSizeWidget] so it can be used
/// as a standard AppBar in a Scaffold.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title displayed in the AppBar.
  final String title;

  /// Creates a [CustomAppBar].
  ///
  /// The [title] is optional and defaults to an empty string.
  const CustomAppBar({
    super.key,
    this.title = "",
  });

  /// Builds the AppBar UI.
  ///
  /// Includes a back button that pops the current route
  /// and a centered title.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0.0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      // Back button
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.grey,
          size: 28,
        ),

        /// Navigates back to the previous screen.
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      // Title
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: true,
    );
  }

  /// Defines the preferred height of the AppBar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}