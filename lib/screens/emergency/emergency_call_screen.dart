import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/custom_app_bar.dart';
import '../../components/emergency_call_button.dart';
import '../../components/scroll_navigator.dart';

class EmergencyCallScreen extends StatelessWidget {
  const EmergencyCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    const Color primaryGreen = Color(0xFF10B981);

    return Scaffold(
      appBar: CustomAppBar(),
      body: ScrollNavigatorWrapper(
        onNavigate: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lang.translate('emergency_call', 'medical_th'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
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
                          Text(lang.translate('emergency_call', 'others'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_191')),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_199')),
                          _buildListItem(
                              lang.translate('emergency_call', 'other_1193')),
                          const SizedBox(height: 24),
                          const Center(
                              child: EmergencyCallButton(phoneNumber: '0000')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48), // Spacing

              // 👇 เปลี่ยนมาใช้ UI Component แทน
              ScrollDownIndicator(
                text: lang.translate('emergency_call', 'scroll_down'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // (ส่วน _buildListItem คงไว้เหมือนเดิม)
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
