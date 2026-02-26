import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _navigateToHome(context),
                  child: const Text("skip >", style: TextStyle(color: primaryColor, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 40),

              // Title Section
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 25,
                    child: const Text("1", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      "What is STAYALIVE?",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Description
              const Text(
                "STAYALIVE is your quick, reliable CPR guide designed for emergencies when every second counts.",
                style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 60),

              // Features Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureItem(Icons.favorite, "Instant\nGuidance"),
                  _buildFeatureItem(Icons.calculate, "Easy using"),
                  _buildFeatureItem(Icons.local_shipping, "Minimal\ndesigns"),
                ],
              ),

              const Spacer(),

              // Pagination Dots (Simulated)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(8, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: index == 0 ? 30 : 12,
                    decoration: BoxDecoration(
                      color: index == 0 ? primaryColor : Colors.grey[400],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToHome(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  icon: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                  label: const Text("Next", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF10B981), size: 50),
        const SizedBox(height: 10),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}