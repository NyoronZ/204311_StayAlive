import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final pages = lang.getTutorialPages();
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- Skip Button ---
            // hide the skip (Opacity = 0)
            Opacity(
              opacity: _currentPage == pages.length - 1 ? 0.0 : 1.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _currentPage == pages.length - 1 
                        ? null 
                        : () {
                            // if not on last page, jump to last page
                            _pageController.animateToPage(
                              pages.length - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
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
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final data = pages[index];
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
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                data['title']!,
                                style: const TextStyle(
                                  fontSize: 22, 
                                  fontWeight: FontWeight.bold
                                ),
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
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        
                        const SizedBox(height: 60),

                        // Features
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFeatureItem(Icons.favorite, data['feat1']!),
                            _buildFeatureItem(Icons.calculate, data['feat2']!),
                            _buildFeatureItem(Icons.local_shipping, data['feat3']!),
                          ],
                        ),
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
                    children: List.generate(pages.length, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 30 : 12,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? primaryColor : Colors.grey[400],
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
                        if (_currentPage < pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          // Home is the main screen after tutorial, so we clear the stack
                          _navigateToHome(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        _currentPage == pages.length - 1 
                            ? lang.translate('common', 'start_btn') // Let's Get Started!
                            : lang.translate('common', 'next'),     // Next
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 22, 
                          fontWeight: FontWeight.bold
                        ),
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

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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