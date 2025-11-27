// Модель вопроса
class Question {
  final int id;
  final String text;
  final List<String> options;
  final String correctAnswer; // A, B, C, D
  final QuestionType type;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.type,
  });
}

// Модель вопроса на соответствие
class MatchingQuestion {
  final int id;
  final String text;
  final Map<String, int> correctAnswers; // A->4, B->1, C->3, D->2

  MatchingQuestion({
    required this.id,
    required this.text,
    required this.correctAnswers,
  });
}

enum QuestionType {
  singleChoice, // A, B, C, D
  matching, // A->1,2,3,4,5
}