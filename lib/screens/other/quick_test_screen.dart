import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language_provider.dart';
import '../../widgets/custom_app_bar.dart';

class QuickTestScreen extends StatefulWidget {
  const QuickTestScreen({super.key});

  @override
  State<QuickTestScreen> createState() => _QuickTestScreenState();
}

class _QuickTestScreenState extends State<QuickTestScreen> {
  int _currentIndex = 0;
  final Map<int, int> _userAnswers = {};
  bool _showResult = false;

  void _handleAnswer(int questionIndex, int optionIndex) {
    if (_userAnswers.containsKey(questionIndex)) return;

    setState(() {
      _userAnswers[questionIndex] = optionIndex;
    });
  }

  void _nextQuestion(int totalQuestions) {
    if (_currentIndex < totalQuestions - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        _showResult = true;
      });
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _resetTest() {
    setState(() {
      _currentIndex = 0;
      _userAnswers.clear();
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final questions = lang.getQuickTestQuestions();

    // Fallback if translate doesn't return Map (it returns key if not found)
    final title = lang.translate('quick_test_screen', 'title');
    final nextText = lang.translate('quick_test_screen', 'next');
    final prevText = lang.translate('quick_test_screen', 'previous');
    final finishText = lang.translate('quick_test_screen', 'finish');
    final scoreText = lang.translate('quick_test_screen', 'score');
    final tryAgainText = lang.translate('quick_test_screen', 'try_again');
    final resultTitle = lang.translate('quick_test_screen', 'result_title');

    if (_showResult) {
      return _buildResultScreen(
          questions, scoreText, resultTitle, tryAgainText);
    }

    final currentQuestion = questions[_currentIndex];
    final selectedIdx = _userAnswers[_currentIndex];
    final isAnswered = selectedIdx != null;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildQuestionCard(currentQuestion, selectedIdx, isAnswered),
            const SizedBox(height: 30),
            _buildNavigationButtons(
                questions.length, nextText, prevText, finishText),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
      Map<String, dynamic> question, int? selectedIdx, bool isAnswered) {
    const primaryGreen = Color(0xFF10B981);
    final options = List<String>.from(question['options']);
    final correctIdx = question['answerIndex'] as int;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryGreen, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with question number
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${_currentIndex + 1}',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question['question'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 25),
                ...List.generate(options.length, (index) {
                  return _buildOptionButton(
                    text: options[index],
                    index: index,
                    selectedIdx: selectedIdx,
                    correctIdx: correctIdx,
                    isAnswered: isAnswered,
                  );
                }),
                if (isAnswered) ...[
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    Provider.of<LanguageProvider>(context, listen: false)
                        .translate('quick_test_screen', 'explanation'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    question['explanation'],
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required int index,
    required int? selectedIdx,
    required int correctIdx,
    required bool isAnswered,
  }) {
    final bool isSelected = selectedIdx == index;
    final bool isCorrect = index == correctIdx;

    Color bgColor = const Color(0xFFC6F6D5).withValues(alpha: 0.5);
    Color borderColor = const Color(0xFF10B981).withValues(alpha: 0.3);
    Widget? icon;

    if (isAnswered) {
      if (isCorrect) {
        bgColor = const Color(0xFFC6F6D5);
        borderColor = const Color(0xFF10B981);
        icon = const Icon(Icons.check_circle_outline,
            color: Color(0xFF10B981), size: 20);
      } else if (isSelected) {
        bgColor = const Color(0xFFFED7D7);
        borderColor = Colors.red.withValues(alpha: 0.5);
        icon = const Icon(Icons.cancel_outlined, color: Colors.red, size: 20);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _handleAnswer(_currentIndex, index),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                icon,
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(
      int total, String nextText, String prevText, String finishText) {
    final bool isLast = _currentIndex == total - 1;
    final bool isAnswered = _userAnswers.containsKey(_currentIndex);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentIndex > 0)
          _buildActionBtn(
            text: prevText,
            onPressed: _previousQuestion,
            color: Colors.grey[600]!,
            icon: Icons.arrow_back_ios_new,
            isLeading: true,
          )
        else
          const SizedBox.shrink(),
        _buildActionBtn(
          text: isLast ? finishText : nextText,
          onPressed: isAnswered ? () => _nextQuestion(total) : null,
          color: const Color(0xFF10B981),
          icon: isLast ? Icons.check : Icons.play_arrow,
          isLeading: false,
        ),
      ],
    );
  }

  Widget _buildActionBtn({
    required String text,
    required VoidCallback? onPressed,
    required Color color,
    required IconData icon,
    required bool isLeading,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLeading) Icon(icon, color: Colors.white, size: 18),
          if (isLeading) const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          if (!isLeading) const SizedBox(width: 8),
          if (!isLeading) Icon(icon, color: Colors.white, size: 18),
        ],
      ),
    );
  }

  Widget _buildResultScreen(List<Map<String, dynamic>> questions,
      String scoreText, String resultTitle, String tryAgainText) {
    int score = 0;
    _userAnswers.forEach((qIdx, aIdx) {
      if (questions[qIdx]['answerIndex'] == aIdx) score++;
    });

    return Scaffold(
      appBar: CustomAppBar(title: resultTitle),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events_outlined,
                  size: 100, color: Color(0xFF10B981)),
              const SizedBox(height: 20),
              Text(
                resultTitle,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$scoreText $score / ${questions.length}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _resetTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  tryAgainText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
