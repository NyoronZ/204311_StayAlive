import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/emergency_call_button.dart';

class EmergencyCallScreen extends StatelessWidget {
  const EmergencyCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const Color primaryGreen =
        Color(0xFF10B981); // Adjusted slightly for a nice green

    return Scaffold(
      appBar: const CustomAppBar(), // Back button only
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          // Detect overscroll past the bottom
          if (notification.metrics.pixels >
              notification.metrics.maxScrollExtent + 60) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
            return true;
          }
          return false;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryGreen, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Green Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        color: primaryGreen,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.airport_shuttle_outlined,
                              color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            lang.translate('emergency_call', 'title'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content Body
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.translate('emergency_call', 'medical_th'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          _buildListItem(
                              lang.translate('emergency_call', 'med_1196')),
                          _buildListItem(
                              lang.translate('emergency_call', 'med_1554')),
                          _buildListItem(
                              lang.translate('emergency_call', 'med_1669')),
                          _buildListItem(
                              lang.translate('emergency_call', 'med_1691')),

                          const SizedBox(height: 16),

                          Text(
                            lang.translate('emergency_call', 'others'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_191')),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_199')),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_1193')),

                          const SizedBox(height: 24),

                          // Call Button
                          const Center(
                            child: EmergencyCallButton(
                              phoneNumber: '0841179098',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48), // Spacing

              // Scroll down indicator
              Text(
                lang.translate('emergency_call', 'scroll_down'),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.keyboard_double_arrow_down, size: 40),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    // Splits the text by '-' to make the number bold like the image?
    // Actually the image doesn't strictly bold the number, but standard text is fine.
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
