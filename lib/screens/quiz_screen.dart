import 'package:flutter/material.dart';
import '../main.dart';

class QuizScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const QuizScreen({
    super.key,
    required this.appState,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int? _selectedAnswer;
  bool _showSlogan = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnswer(int answer) {
    setState(() {
      _selectedAnswer = answer;
      if (answer == 1) {
        // "Leave it behind" is correct
        _showSlogan = true;
        _animationController.forward();
      } else {
        _showSlogan = false;
      }
    });
  }

  String _getQuestion() {
    return widget.appState.language == 'en'
        ? 'In an evacuation, what should you do with your carry-on luggage?'
        : '¿En una evacuación, qué debes hacer con tu equipaje de mano?';
  }

  String _getOptionTake() {
    return widget.appState.language == 'en' ? 'Take it with me' : 'Llevarlo conmigo';
  }

  String _getOptionLeave() {
    return widget.appState.language == 'en' ? 'Leave it behind' : 'Dejarlo atrás';
  }

  String _getSlogan() {
    return widget.appState.language == 'en'
        ? "Don't lag, leave your bag!"
        : "¡No rezagues, deja tu bolsa!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Quiz'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Progress indicator
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFED4E),
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Color(0xFF0B1929),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: Color(0xFF00D4FF),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF888888), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Color(0xFF888888),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),

              // Question
              Text(
                _getQuestion(),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),

              // Answer Buttons
              _buildAnswerButton(
                text: _getOptionTake(),
                isSelected: _selectedAnswer == 0,
                onPressed: () => _handleAnswer(0),
                isCorrect: false,
              ),
              SizedBox(height: 24),
              _buildAnswerButton(
                text: _getOptionLeave(),
                isSelected: _selectedAnswer == 1,
                onPressed: () => _handleAnswer(1),
                isCorrect: _selectedAnswer == 1,
              ),
              SizedBox(height: 32),

              // Slogan with animation
              if (_showSlogan)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF00FF41), width: 3),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF1A2E4A),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '✓ Correct!',
                          style: TextStyle(
                            color: Color(0xFF00FF41),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          _getSlogan(),
                          style: TextStyle(
                            color: Color(0xFFFFED4E),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 48),

              // Navigation Buttons
              if (_selectedAnswer != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: widget.onPrevious,
                      child: Text(
                        widget.appState.language == 'en' ? 'Back' : 'Atrás',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _selectedAnswer == 1 ? widget.onNext : null,
                      child: Text(
                        widget.appState.language == 'en' ? 'Next' : 'Siguiente',
                      ),
                    ),
                  ],
                )
              else
                OutlinedButton(
                  onPressed: widget.onPrevious,
                  child: Text(
                    widget.appState.language == 'en' ? 'Back' : 'Atrás',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
    required bool isCorrect,
  }) {
    Color borderColor = Colors.transparent;
    Color backgroundColor = Color(0xFF1A2E4A);

    if (isSelected) {
      borderColor = isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444);
      backgroundColor = isCorrect
          ? Color(0xFF1A2E4A).withOpacity(0.8)
          : Color(0xFF1A2E4A).withOpacity(0.8);
    }

    return OutlinedButton(
      onPressed: _selectedAnswer == null ? onPressed : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor,
          width: isSelected ? 4 : 2,
        ),
        backgroundColor: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected && isCorrect
                      ? Color(0xFF00FF41)
                      : isSelected
                          ? Color(0xFFFF4444)
                          : Color(0xFFFFED4E),
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  isCorrect ? '✓' : '✗',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
