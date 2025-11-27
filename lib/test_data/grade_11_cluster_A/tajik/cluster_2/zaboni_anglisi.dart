// test_data/grade_11_cluster_A/tajik/cluster_2/zaboni_anglisi.dart

import 'package:test_cluster/model/Test%20question%20simple.dart';


class ZaboniAnglisiCluster2Tajik {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'What is the capital of England?',
        options: [
          'A) Manchester',
          'B) London',
          'C) Liverpool',
          'D) Birmingham',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: 'Choose the correct form: I ___ to school every day.',
        options: [
          'A) go',
          'B) goes',
          'C) going',
          'D) gone',
        ],
        correctAnswer: 'A',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'What is the past tense of "eat"?',
        options: [
          'A) eated',
          'B) ate',
          'C) eaten',
          'D) eating',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
    ];
  }

  static List<MatchingQuestion> getMatchingQuestions() {
    return [
      MatchingQuestion(
        id: 21,
        text: 'Match the words:\nA) Morning\nB) Afternoon\nC) Evening\nD) Night',
        correctAnswers: {
          'A': 1, // Утро
          'B': 2, // День
          'C': 3, // Вечер
          'D': 4, // Ночь
        },
      ),
    ];
  }
}