import 'package:test_cluster/model/Test%20question%20simple.dart';


class XimiyaCluster1Russian {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'Формула воды?',
        options: [
          'A) H₂O',
          'B) CO₂',
          'C) O₂',
          'D) N₂',
        ],
        correctAnswer: 'A',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: 'Какой элемент является металлом?',
        options: [
          'A) Кислород',
          'B) Натрий',
          'C) Углерод',
          'D) Азот',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'pH чистой воды?',
        options: [
          'A) 7',
          'B) 5',
          'C) 8',
          'D) 3',
        ],
        correctAnswer: 'A',
        type: QuestionType.singleChoice,
      ),
    ];
  }

  static List<MatchingQuestion> getMatchingQuestions() {
    return [];
  }
}