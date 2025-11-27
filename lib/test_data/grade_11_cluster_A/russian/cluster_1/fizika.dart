
import 'package:test_cluster/model/Test%20question%20simple.dart';

class FizikaCluster1Russian {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'Скорость света в вакууме?',
        options: [
          'A) 300,000 км/с',
          'B) 150,000 км/с',
          'C) 450,000 км/с',
          'D) 600,000 км/с',
        ],
        correctAnswer: 'A',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: 'Единица измерения силы?',
        options: [
          'A) Джоуль',
          'B) Ньютон',
          'C) Ватт',
          'D) Паскаль',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'Ускорение свободного падения?',
        options: [
          'A) 9.8 м/с²',
          'B) 8.9 м/с²',
          'C) 10.5 м/с²',
          'D) 7.5 м/с²',
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