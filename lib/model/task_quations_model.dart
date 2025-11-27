// Модель вопроса теста
class TestQuestion {
  final int id;
  final String subjectId; // ID предмета
  final String language; // 'tj' или 'ru'
  final QuestionType type; // Тип вопроса
  final String questionText;
  final List<String> options; // Варианты ответа
  final dynamic correctAnswer; // int для single, List<Map> для matching
  final String? imageUrl;

  TestQuestion({
    required this.id,
    required this.subjectId,
    required this.language,
    required this.type,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.imageUrl,
  });
}

// Типы вопросов
enum QuestionType {
  singleChoice,  // Выбор одного ответа (A, B, C, D)
  matching,      // На соответствие (A-1,2,3,4,5)
}

// Результат ответа пользователя
class UserAnswer {
  final int questionId;
  final dynamic answer;
  final bool isCorrect;
  final DateTime answeredAt;

  UserAnswer({
    required this.questionId,
    required this.answer,
    required this.isCorrect,
    required this.answeredAt,
  });
}

// Результат теста
class TestResult {
  final String id;
  final String subjectId;
  final String language;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final DateTime completedAt;
  final int timeSpentSeconds;
  final List<UserAnswer> answers;

  TestResult({
    required this.id,
    required this.subjectId,
    required this.language,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedQuestions,
    required this.completedAt,
    required this.timeSpentSeconds,
    required this.answers,
  });

  double get percentage => (correctAnswers / totalQuestions * 100);

  String get grade {
    if (percentage >= 90) return 'Аъло'; // Отлично
    if (percentage >= 75) return 'Хуб'; // Хорошо
    if (percentage >= 60) return 'Қаноатбахш'; // Удовлетворительно
    return 'Норозӣ'; // Неудовлетворительно
  }
}

// Класс с примерами вопросов (из PDF)
class TestQuestionsData {
  // Пример вопросов для таджикского языка (из субтеста)
  static List<TestQuestion> getTajikLanguageSample() {
    return [
      // Вопрос 1 - Ответ: D
      TestQuestion(
        id: 1,
        subjectId: '9_tojiki',
        language: 'tj',
        type: QuestionType.singleChoice,
        questionText: 'Дар кадом ҷумла калимаи "бахт" маънии "саодат"-ро ифода мекунад?',
        options: [
          'A) Бахти ман ба як даме расид',
          'B) Бахти туро хуб бувад',
          'C) Дар ин кор бахте надорам',
          'D) Бахти саодатманд будан'
        ],
        correctAnswer: 3, // D (индекс 3)
      ),
      
      // Вопрос 2 - Ответ: C
      TestQuestion(
        id: 2,
        subjectId: '9_tojiki',
        language: 'tj',
        type: QuestionType.singleChoice,
        questionText: 'Кадом калима дар ҷумла вазифаи муайянкунанда дорад?',
        options: [
          'A) Хонаи калон',
          'B) Китоби нав',
          'C) Дарахти баланд',
          'D) Одами хуб'
        ],
        correctAnswer: 2, // C
      ),
      
      // Вопрос 3 - Ответ: A
      TestQuestion(
        id: 3,
        subjectId: '9_tojiki',
        language: 'tj',
        type: QuestionType.singleChoice,
        questionText: 'Синоними калимаи "зебо" кадом аст?',
        options: [
          'A) Хушрӯ',
          'B) Калон',
          'C) Хуб',
          'D) Нек'
        ],
        correctAnswer: 0, // A
      ),
      
      // Вопрос 21 - На соответствие - Ответ: A-4, B-5, C-1, D-3
      TestQuestion(
        id: 21,
        subjectId: '9_tojiki',
        language: 'tj',
        type: QuestionType.matching,
        questionText: 'Мувофиқатро ёбед:',
        options: [
          'A) Адабиёт',
          'B) Санъат',
          'C) Илм',
          'D) Маърифат'
        ],
        correctAnswer: {
          'A': 4,
          'B': 5,
          'C': 1,
          'D': 3,
        },
      ),
    ];
  }
  
  // Генерация случайного теста
  static List<TestQuestion> generateRandomTest({
    required String subjectId,
    required String language,
    required int questionsCount,
  }) {
    // TODO: В будущем загружать из базы данных
    // Пока возвращаем пример
    return getTajikLanguageSample().take(questionsCount).toList();
  }
}