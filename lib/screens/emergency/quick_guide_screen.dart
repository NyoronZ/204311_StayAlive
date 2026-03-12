import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../components/custom_app_bar.dart';
import '../../components/symptom_check_card.dart';

import '../../components/scroll_navigator.dart';

class QuickGuideScreen extends StatefulWidget {
  const QuickGuideScreen({super.key});

  @override
  State<QuickGuideScreen> createState() => _QuickGuideScreenState();
}

class _QuickGuideScreenState extends State<QuickGuideScreen> {
  String? _selectedAgeGroup;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final cardsData = languageProvider.getQuickGuideCards();
    final ageSelectText = languageProvider.getQuickGuideAgeSelect();

    List<Map<String, dynamic>>? additionalCprCards;
    if (_selectedAgeGroup == 'adult') {
      additionalCprCards = languageProvider.getQuickGuideAdultCpr();
    } else if (_selectedAgeGroup == 'infant_child') {
      additionalCprCards = languageProvider.getQuickGuideChildCpr();
    }

    final List<Widget> listItems = [];

    for (int i = 0; i < cardsData.length; i++) {
      final cardData = cardsData[i];
      listItems.add(QuickGuideCard(
        number: cardData['number'],
        title: cardData['title'],
        description: cardData['description'],
        keyPoints: cardData['keyPoints'] != null
            ? List<String>.from(cardData['keyPoints'])
            : null,
      ));
    }

    listItems.add(const SymptomCheckCard());
    listItems.add(_buildAgeSelectionCard(ageSelectText));

    if (additionalCprCards != null) {
      for (int i = 0; i < additionalCprCards.length; i++) {
        final cardData = additionalCprCards[i];
        String? imagePath;
        if (_selectedAgeGroup == 'adult') {
          if (i == 2) imagePath = 'assets/images/cpr.png';
          if (i == 3) imagePath = 'assets/images/breath.png';
        } else if (_selectedAgeGroup == 'infant_child') {
          if (i == 2) imagePath = 'assets/images/breath_infant.png';
          if (i == 3) imagePath = 'assets/images/cpr_infant.png';
        }

        listItems.add(QuickGuideCard(
          number: cardData['number'],
          title: cardData['title'],
          description: cardData['description'],
          keyPoints: null,
          imagePath: imagePath,
        ));
      }
    }

    listItems.add(ScrollDownIndicator(
      text: languageProvider.translate('emergency_call', 'scroll_down'),
    ));

    return Scaffold(
      appBar: CustomAppBar(
          title: languageProvider.translate('home', 'quick_guide')),
      body: ScrollNavigatorWrapper(
        onNavigate: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          padding: const EdgeInsets.all(16.0),
          itemCount: listItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => listItems[index],
        ),
      ),
    );
  }

  Widget _buildAgeSelectionCard(Map<String, String> texts) {
    const mainGreen = Color(0xFF10B981);

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
                    '4',
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
                    texts['title'] ?? 'Select Patient Age',
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
            padding: const EdgeInsets.all(16.0),
            child: _selectedAgeGroup == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        texts['desc'] ?? 'Choose proper CPR steps below:',
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _selectedAgeGroup = 'adult'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          texts['adult'] ?? 'Adult (>8 years)',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _selectedAgeGroup = 'infant_child'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.blue[900]
                                  : Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          texts['infant_child'] ?? 'Infant & Child (<8 yrs)',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${texts['selected_prefix'] ?? 'Selected Age:'}\n${_selectedAgeGroup == 'adult' ? texts['adult'] : texts['infant_child']}',
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            setState(() => _selectedAgeGroup = null),
                        icon: const Icon(Icons.refresh, color: mainGreen),
                        label: Text(texts['change'] ?? 'Change',
                            style: const TextStyle(color: mainGreen)),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class QuickGuideCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final List<String>? keyPoints;
  final String? imagePath;

  const QuickGuideCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    this.keyPoints,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    const mainGreen = Color(0xFF10B981);
    const lightGreen = Color(0xFFA5F0C5);
    const lightGreenBorder = Color(0xFF69F0AE);

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
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.white,
                  radius: 20,
                  child: Text(
                    number,
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
                    title,
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
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath!,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
                if (keyPoints != null && keyPoints!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? mainGreen.withOpacity(0.1)
                          : lightGreen.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? mainGreen.withOpacity(0.3)
                              : lightGreenBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageProvider.translate(
                              'quick-guide', 'key-points'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...keyPoints!.map((point) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      point,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
