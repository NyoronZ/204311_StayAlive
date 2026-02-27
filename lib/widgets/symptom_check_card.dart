import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import 'emergency_call_button.dart';

class SymptomCheckCard extends StatefulWidget {
  const SymptomCheckCard({super.key});

  @override
  State<SymptomCheckCard> createState() => _SymptomCheckCardState();
}

class _SymptomCheckCardState extends State<SymptomCheckCard> {
  // Keeping track of which symptoms are selected
  bool _unconscious = false;
  bool _abnormalBreathing = false;
  bool _severeBleeding = false;
  bool _convulsion = false;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    const mainGreen = Color(0xFF10B981);

    bool hasAnySymptom =
        _unconscious || _abnormalBreathing || _severeBleeding || _convulsion;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mainGreen, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: mainGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Text(
                    "X",
                    style: TextStyle(
                      color: mainGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    languageProvider.translate('quick-guide-symptoms', 'title'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        languageProvider.translate(
                            'quick-guide-symptoms', 'instruction'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Symptom Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildSymptomButton(
                        label: languageProvider.translate(
                            'quick-guide-symptoms', 'sym_unconscious'),
                        isSelected: _unconscious,
                        onTap: () {
                          setState(() {
                            _unconscious = !_unconscious;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSymptomButton(
                        label: languageProvider.translate(
                            'quick-guide-symptoms', 'sym_abnormal_breathing'),
                        isSelected: _abnormalBreathing,
                        onTap: () {
                          setState(() {
                            _abnormalBreathing = !_abnormalBreathing;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSymptomButton(
                        label: languageProvider.translate(
                            'quick-guide-symptoms', 'sym_severe_bleeding'),
                        isSelected: _severeBleeding,
                        onTap: () {
                          setState(() {
                            _severeBleeding = !_severeBleeding;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSymptomButton(
                        label: languageProvider.translate(
                            'quick-guide-symptoms', 'sym_convulsion'),
                        isSelected: _convulsion,
                        onTap: () {
                          setState(() {
                            _convulsion = !_convulsion;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Emergency Call Button Section
          if (hasAnySymptom)
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Center(
                child: EmergencyCallButton(
                  phoneNumber: '0841179098',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSymptomButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    const mainGreen = Color(0xFF10B981);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? mainGreen : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: mainGreen, width: 1.5),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: mainGreen.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
