
import 'package:test_cluster/model/Test%20question%20simple.dart' show Question, MatchingQuestion, QuestionType;

class XimiyaCluster1Tajik {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'Формулаи обӣ кадом аст?',
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
        text: 'Кадом унсур металл аст?',
        options: [
          'A) Оксиген',
          'B) Натрий',
          'C) Карбон',
          'D) Азот',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'pH оби сода чанд аст?',
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