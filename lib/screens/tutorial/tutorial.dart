/*
 * File: tutorial.dart
 * Description: Full-screen tutorial flow shown on first app launch.
 *              Guides the user through app features across multiple pages,
 *              with a CPR reference page embedded at position 5.
 *
 * Dependencies:
 * - LanguageProvider
 * - HowToCprScreen
 * - SharedPreferences (to persist tutorial completion state)
 *
 * Lifecycle:
 * - Created on first launch before the Home screen
 * - Disposed after the user completes or skips the tutorial
 *
 * Author: Rattanun Deewongsai
 * Course: Mobile Application Development Framework
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/language_provider.dart';
import 'how_to_cpr.dart';

/// Full-screen tutorial displayed on the first app launch.
///
/// Fields:
/// - (stateless) — all state is held in [_TutorialScreenState]
///
/// Usage:
/// - Pushed as the initial route when [hasSeenTutorial] is false
/// - Navigates to Home and clears the stack on completion or skip
class TutorialScreen extends StatefulWidget {
  /// Creates a [TutorialScreen].
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// Builds the tutorial UI with a paged layout.
  ///
  /// Renders a skip button, a [PageView] of tutorial slides (including
  /// [HowToCprScreen] at index 5), pagination dots, and a Next/Start button.
  ///
  /// Side effects:
  /// - Writes [hasSeenTutorial] to SharedPreferences on skip or completion
  /// - Navigates to Home and clears the Navigator stack when done
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final pages = lang.getTutorialPages();
    const primaryColor = Color(0xFF10B981);

    Future<void> completeTutorial() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenTutorial', true);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- Skip Button ---
            // hide the skip (Opacity = 0)
            Opacity(
              opacity: _currentPage == pages.length ? 0.0 : 1.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _currentPage == pages.length
                        ? null
                        : () async {
                            // if not on last page, jump to last page
                            _pageController.animateToPage(
                              pages.length,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            // Set flag even on skip
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenTutorial', true);
                          },
                    child: Text(
                      lang.translate('common', 'skip'),
                      style: const TextStyle(color: primaryColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

            // --- PageView Content ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: pages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 5) {
                    return const HowToCprScreen();
                  }

                  final dataIndex = index > 5 ? index - 1 : index;
                  final data = pages[dataIndex];

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Title Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 25,
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                data['title']!,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Description
                        Text(
                          data['desc']!,
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 40),

                        // Features or List Items
                        if (data.containsKey('list_items'))
                          ...((data['list_items'] as List).map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['desc']!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList())
                        else if (data.containsKey('image'))
                          Center(
                            child: Image.asset(data['image']!,
                                height: 200, fit: BoxFit.contain),
                          )
                        else
                          (() {
                            List<IconData> getIconsForPage(int pageIdx) {
                              switch (pageIdx) {
                                case 0:
                                  return [
                                    Icons.bolt,
                                    Icons.touch_app,
                                    Icons.palette
                                  ];
                                case 1:
                                  return [
                                    Icons.accessibility_new,
                                    Icons.music_note,
                                    Icons.timer
                                  ];
                                case 2:
                                  return [
                                    Icons.visibility,
                                    Icons.health_and_safety,
                                    Icons.monitor_heart
                                  ];
                                case 3:
                                  return [
                                    Icons.dialpad,
                                    Icons.contact_phone,
                                    Icons.location_on
                                  ];
                                case 4:
                                  return [
                                    Icons.quiz,
                                    Icons.menu_book,
                                    Icons.assignment_turned_in
                                  ];
                                default:
                                  return [
                                    Icons.favorite,
                                    Icons.calculate,
                                    Icons.local_shipping
                                  ];
                              }
                            }

                            final icons = getIconsForPage(dataIndex);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFeatureItem(icons[0], data['feat1']!),
                                _buildFeatureItem(icons[1], data['feat2']!),
                                _buildFeatureItem(icons[2], data['feat3']!),
                              ],
                            );
                          }())
                      ],
                    ),
                  );
                },
              ),
            ),

            // --- Bottom Section: Dots & Button ---
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  // Pagination Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        pages.length + 1,
                        (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: _currentPage == index ? 30 : 12,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? primaryColor
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            )),
                  ),
                  const SizedBox(height: 30),

                  // Next / Start Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < pages.length) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          // Home is the main screen after tutorial, so we clear the stack
                          completeTutorial();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        _currentPage == pages.length
                            ? lang.translate(
                                'common', 'start_btn') // Let's Get Started!
                            : lang.translate('common', 'next'), // Next
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 50),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
