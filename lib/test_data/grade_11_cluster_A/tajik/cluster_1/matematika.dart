// test_data/grade_11_cluster_A/tajik/cluster_1/matematika.dart


import 'package:test_cluster/model/Test%20question%20simple.dart';

class MatematikaCluster1Tajik {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: '2 + 2 = ?',
        options: [
          'A) 2',
          'B) 3',
          'C) 4',
          'D) 5',
        ],
        correctAnswer: 'C',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: '5 × 3 = ?',
        options: [
          'A) 8',
          'B) 15',
          'C) 20',
          'D) 25',
        ],
        correctAnswer: 'B',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: '10 ÷ 2 = ?',
        options: [
          'A) 2',
          'B) 5',
          'C) 8',
          'D) 10',
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
        text: 'Мувофиқатро ёбед:\nA) 2²\nB) 3²\nC) 4²\nD) 5²',
        correctAnswers: {
          'A': 4, // 2² = 4
          'B': 9, // 3² = 9 -> индекс нет, но можно использовать
          'C': 16,
          'D': 25,
        },
      ),
    ];
  }
}