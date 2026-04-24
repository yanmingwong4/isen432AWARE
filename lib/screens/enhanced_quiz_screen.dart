import 'package:flutter/material.dart';
import '../main.dart';
import '../controllers/quiz_controller.dart';
import '../widgets/progress_bar.dart';

class EnhancedQuizScreen extends StatefulWidget {
  final AppState appState;
  final VoidCallback onComplete;

  const EnhancedQuizScreen({
    super.key,
    required this.appState,
    required this.onComplete,
  });

  @override
  State<EnhancedQuizScreen> createState() => _EnhancedQuizScreenState();
}

class _EnhancedQuizScreenState extends State<EnhancedQuizScreen>
    with SingleTickerProviderStateMixin {
  late QuizController _quizController;
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _quizController = QuizController(language: widget.appState.language);
    _feedbackController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _feedbackAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _handleAnswer(int answerIndex) {
    _quizController.answerQuestion(answerIndex);
    _feedbackController.forward();
    setState(() {});
  }

  String _getText(String enText, String esText) {
    return widget.appState.language == 'en' ? enText : esText;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizController.quizComplete) {
      return _buildResultsScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getText('Safety Quiz', 'Cuestionario de Seguridad')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              ProgressBar(
                current: _quizController.currentProgress,
                total: _quizController.totalQuestions,
                percentage: _quizController.progressPercent,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Q${_quizController.currentProgress}',
                    style: TextStyle(
                      color: Color(0xFFFFED4E),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      _quizController.getCategory(),
                      style: TextStyle(
                        color: Color(0xFF00D4FF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              if (_quizController.currentQuestion.iconEmoji != null)
                Text(
                  _quizController.currentQuestion.iconEmoji!,
                  style: TextStyle(fontSize: 56),
                ),
              SizedBox(height: 16),
              Text(
                _quizController.getQuestion(),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              ...List.generate(
                _quizController.currentQuestion.options.length,
                (idx) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: _buildAnswerButton(idx),
                ),
              ),
              SizedBox(height: 32),
              if (_quizController.showFeedback)
                FadeTransition(
                  opacity: _feedbackAnimation,
                  child: _buildFeedbackSection(),
                ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_quizController.currentQuestionIndex > 0)
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _quizController.previousQuestion();
                          _feedbackController.reset();
                        });
                      },
                      child: Text(_getText('Back', 'Atrás')),
                    ),
                  if (_quizController.showFeedback)
                    ElevatedButton(
                      onPressed: _quizController.currentQuestionIndex <
                              _quizController.totalQuestions - 1
                          ? () {
                              setState(() {
                                _quizController.nextQuestion();
                                _feedbackController.reset();
                              });
                            }
                          : () {
                              widget.onComplete();
                            },
                      child: Text(
                        _quizController.currentQuestionIndex <
                                _quizController.totalQuestions - 1
                            ? _getText('Next', 'Siguiente')
                            : _getText('Finish', 'Terminar'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int index) {
    final option = _quizController.currentQuestion.options[index];
    final isSelected =
        _quizController.userAnswers[_quizController.currentQuestionIndex] ==
            index;
    final isCorrect =
        index == _quizController.currentQuestion.correctAnswerIndex;
    final showResult = _quizController.showFeedback && isSelected;

    Color borderColor = Colors.transparent;
    if (isSelected && _quizController.showFeedback) {
      borderColor = isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444);
    }

    return OutlinedButton(
      onPressed:
          !_quizController.showFeedback ? () => _handleAnswer(index) : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor,
          width: showResult ? 4 : 2,
        ),
        backgroundColor: Color(0xFF1A2E4A),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                option.getText(widget.appState.language),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: showResult
                      ? (isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444))
                      : Color(0xFFFFED4E),
                ),
              ),
            ),
            if (showResult)
              Padding(
                padding: EdgeInsets.only(left: 12),
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

  Widget _buildFeedbackSection() {
    final isCorrect = _quizController.isAnswerCorrect;
    final borderColor = isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444);
    final textColor = isCorrect ? Color(0xFF00FF41) : Color(0xFFFF4444);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF1A2E4A).withOpacity(0.8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                isCorrect ? '✓ ' : '✗ ',
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  isCorrect
                      ? _getText('Correct!', '¡Correcto!')
                      : _getText('Incorrect', '¡Incorrecto!'),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF0B1929),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _quizController.getSafetyTip(),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsScreen() {
    final percentage = _quizController.getScorePercentage();
    final performanceMsg = _quizController.getPerformanceMessage();

    return Scaffold(
      appBar: AppBar(
        title: Text(_getText('Quiz Complete', 'Cuestionario Completo')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                _getText('Quiz Results', 'Resultados del Cuestionario'),
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: percentage >= 70
                        ? Color(0xFF00FF41)
                        : Color(0xFFFFED4E),
                    width: 6,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          color: percentage >= 70
                              ? Color(0xFF00FF41)
                              : Color(0xFFFFED4E),
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getText('Score', 'Puntuación'),
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00FF41).withOpacity(0.2),
                        ),
                        child: Text(
                          '✓',
                          style: TextStyle(
                            color: Color(0xFF00FF41),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '${_quizController.correctCount}',
                        style: TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getText('Correct', 'Correctas'),
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF4444).withOpacity(0.2),
                        ),
                        child: Text(
                          '✗',
                          style: TextStyle(
                            color: Color(0xFFFF4444),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '${_quizController.wrongCount}',
                        style: TextStyle(
                          color: Color(0xFFFF4444),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getText('Incorrect', 'Incorrectas'),
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: percentage >= 70
                        ? Color(0xFF00FF41)
                        : Color(0xFFFFED4E),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF1A2E4A),
                ),
                child: Text(
                  performanceMsg,
                  style: TextStyle(
                    color: percentage >= 70
                        ? Color(0xFF00FF41)
                        : Color(0xFFFFED4E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _quizController.resetQuiz();
                      });
                    },
                    child: Text(_getText('Retake Quiz', 'Repetir Quiz')),
                  ),
                  ElevatedButton(
                    onPressed: widget.onComplete,
                    child: Text(_getText('Continue', 'Continuar')),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
