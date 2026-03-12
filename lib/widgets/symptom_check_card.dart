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
  // Keeping track of which symptoms are selected based on the new criteria
  final Map<String, bool> _cprConditions = {
    'cardiac_arrest': false,
    'unconsciousness': false,
    'choking': false,
    'severe_trauma': false,
    'drug_overdose': false,
    'drowning': false,
    'electric_shock': false,
    'severe_allergic_reaction': false,
    'toxic_gas_smoke': false,
    'not_breathing': false,
  };

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    const mainGreen = Color(0xFF10B981);

    // Drowning AND Not Breathing
    bool dnb = _cprConditions['drowning']! && _cprConditions['not_breathing']!;

    // Heart Attack (cardiac_arrest) AND Not Breathing
    bool hnb =
        _cprConditions['cardiac_arrest']! && _cprConditions['not_breathing']!;

    // Drug Overdose AND Not Breathing
    bool donb =
        _cprConditions['drug_overdose']! && _cprConditions['not_breathing']!;

    // Electric Shock AND Not Breathing
    bool eun =
        _cprConditions['electric_shock']! && _cprConditions['not_breathing']!;

    // Choking AND Unconscious AND Not Breathing
    bool cun = _cprConditions['choking']! &&
        _cprConditions['unconsciousness']! &&
        _cprConditions['not_breathing']!;

    // Severe Trauma AND Unconscious AND Not Breathing
    bool stun = _cprConditions['severe_trauma']! &&
        _cprConditions['unconsciousness']! &&
        _cprConditions['not_breathing']!;

    // Severe Allergic Reaction AND Not Breathing
    bool anb = _cprConditions['severe_allergic_reaction']! &&
        _cprConditions['not_breathing']!;

    // Toxic Gas or Smoke AND Not Breathing
    bool tnb =
        _cprConditions['toxic_gas_smoke']! && _cprConditions['not_breathing']!;

    // General Rule: Unconscious AND Not Breathing
    bool gen =
        _cprConditions['unconsciousness']! && _cprConditions['not_breathing']!;

    bool needsCpr =
        dnb || hnb || donb || eun || cun || stun || anb || tnb || gen;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: mainGreen, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: mainGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white,
                      radius: 20,
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : mainGreen,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        languageProvider.translate(
                            'cpr_conditions', 'title_when_cpr'),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
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
                                'cpr_conditions', 'instruction'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Map conditions to cards
                    ..._buildSymptomGrid(languageProvider),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (needsCpr) const SizedBox(height: 16),
        if (needsCpr) _buildCprRequiredCard(languageProvider),
        if (needsCpr) const SizedBox(height: 16),
        if (needsCpr) _buildStartCprCard(context, languageProvider),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStartCprCard(
      BuildContext context, LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.play_circle_fill,
                    color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    languageProvider.currentLocale.languageCode == 'th'
                        ? 'เริ่มทำ CPR (แบบโต้ตอบ)'
                        : 'Start Interactive CPR',
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  languageProvider.currentLocale.languageCode == 'th'
                      ? 'ระบบจะพาคุณเข้าสู่หน้าจอแนะนำจังหวะการทำ CPR และการเป่าปาก พร้อมเสียงประกอบเพื่อความถูกต้องตามมาตรฐาน'
                      : 'This will launch the interactive CPR guide with audio pacing to help you maintain the correct rhythm and timings.',
                  style: const TextStyle(fontSize: 16, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/start');
                  },
                  icon: const Icon(Icons.bolt, color: Colors.white, size: 24),
                  label: Text(
                    languageProvider.translate('home', 'start'),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CPR Required Card show selected symptoms informations
  Widget _buildCprRequiredCard(LanguageProvider languageProvider) {
    const mainGreen = Color(0xFF10B981);

    // Get currently selected symptoms
    String symptomText = _cprConditions.entries
        .where((e) => e.value)
        .map((e) => languageProvider.translate('cpr_conditions', e.key))
        .join(', ');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mainGreen, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
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
                const Icon(Icons.favorite_border,
                    color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    languageProvider.translate('cpr_required', 'title'),
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

          // Body
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageProvider.translate('cpr_required', 'follow_steps'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        "${languageProvider.translate('cpr_required', 'symptoms')} $symptomText",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    languageProvider.translate('cpr_required', 'press_button'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: EmergencyCallButton(phoneNumber: '1669'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSymptomToggle(String key, LanguageProvider languageProvider) {
    setState(() {
      _cprConditions[key] = !_cprConditions[key]!;
    });
  }

  List<Widget> _buildSymptomGrid(LanguageProvider languageProvider) {
    List<Widget> rows = [];
    List<String> keys = _cprConditions.keys.toList();

    for (int i = 0; i < keys.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(
              child: _buildSymptomButton(
                label: languageProvider.translate('cpr_conditions', keys[i]),
                isSelected: _cprConditions[keys[i]]!,
                onTap: () => _handleSymptomToggle(keys[i], languageProvider),
              ),
            ),
            const SizedBox(width: 12),
            if (i + 1 < keys.length)
              Expanded(
                child: _buildSymptomButton(
                  label:
                      languageProvider.translate('cpr_conditions', keys[i + 1]),
                  isSelected: _cprConditions[keys[i + 1]]!,
                  onTap: () =>
                      _handleSymptomToggle(keys[i + 1], languageProvider),
                ),
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      if (i + 2 < keys.length) {
        rows.add(const SizedBox(height: 12));
      }
    }
    return rows;
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
        height: 70, // Slightly shorter for grid packing
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? mainGreen : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: mainGreen, width: 1.5),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: mainGreen.withValues(alpha: 0.3),
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
                  color: isSelected
                      ? Colors.white
                      : (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87),
                  fontSize: 13, // Slightly smaller text
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
