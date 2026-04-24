import '../models/quiz_data.dart';

class QuizController {
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;
  final Map<int, int?> _userAnswers = {};
  int _correctCount = 0;
  int _wrongCount = 0;
  bool _showFeedback = false;
  bool _isAnswerCorrect = false;
  String _language = 'en';

  QuizController({String language = 'en'}) {
    _language = language;
    _questions = allQuizQuestions;
  }

  // Getters
  List<QuizQuestion> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];
  int get totalQuestions => _questions.length;
  double get progressPercent =>
      (_currentQuestionIndex + 1) / _questions.length;
  Map<int, int?> get userAnswers => _userAnswers;
  int get correctCount => _correctCount;
  int get wrongCount => _wrongCount;
  bool get showFeedback => _showFeedback;
  bool get isAnswerCorrect => _isAnswerCorrect;
  String get language => _language;
  bool get quizComplete => _currentQuestionIndex >= _questions.length;
  int get currentProgress => _currentQuestionIndex + 1;

  void setLanguage(String lang) {
    _language = lang;
  }

  void answerQuestion(int answerIndex) {
    _userAnswers[_currentQuestionIndex] = answerIndex;
    _isAnswerCorrect =
        answerIndex == currentQuestion.correctAnswerIndex;

    if (_isAnswerCorrect) {
      _correctCount++;
    } else {
      _wrongCount++;
    }

    _showFeedback = true;
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _showFeedback = false;
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _showFeedback = false;
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      _showFeedback = false;
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _correctCount = 0;
    _wrongCount = 0;
    _showFeedback = false;
  }

  void hideFeedback() {
    _showFeedback = false;
  }

  String getSafetyTip() => currentQuestion.getSafetyTip(_language);

  String getCategory() => currentQuestion.getCategory(_language);

  String getQuestion() => currentQuestion.getQuestion(_language);

  List<String> getOptions() {
    return currentQuestion.options
        .map((opt) => opt.getText(_language))
        .toList();
  }

  // Calculate score percentage
  int getScorePercentage() {
    if (totalQuestions == 0) return 0;
    return ((_correctCount / totalQuestions) * 100).toInt();
  }

  // Get performance message
  String getPerformanceMessage() {
    final percentage = getScorePercentage();
    if (_language == 'en') {
      if (percentage == 100) return 'Perfect! You\'re a safety expert!';
      if (percentage >= 80) return 'Excellent understanding of flight safety.';
      if (percentage >= 60) return 'Good knowledge. Review the safety tips!';
      if (percentage >= 40) {
        return 'Keep learning about aviation safety.';
      }
      return 'Please review all safety procedures.';
    } else {
      if (percentage == 100) return '¡Perfecto! ¡Eres un experto en seguridad!';
      if (percentage >= 80) {
        return 'Excelente comprensión de la seguridad aérea.';
      }
      if (percentage >= 60) {
        return 'Buen conocimiento. ¡Revisa los consejos!';
      }
      if (percentage >= 40) {
        return 'Sigue aprendiendo sobre seguridad aérea.';
      }
      return 'Por favor, revisa todos los procedimientos.';
    }
  }
}
