// test_data/grade_11_cluster_A/tajik/cluster_1/zaboni_tojiki.dart



import 'package:test_cluster/model/Test%20question%20simple.dart';

class ZaboniTojikiCluster1Tajik {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'Дар кадом ҷумла калимаи "бахт" маънии "саодат"-ро ифода мекунад?',
        options: [
          'A) Бахти ман ба як даме расид',
          'B) Бахти туро хуб бувад',
          'C) Дар ин кор бахте надорам',
          'D) Бахти саодатманд будан',
        ],
        correctAnswer: 'D',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: 'Кадом калима дар ҷумла вазифаи муайянкунанда дорад?',
        options: [
          'A) Хонаи калон',
          'B) Китоби нав',
          'C) Дарахти баланд',
          'D) Одами хуб',
        ],
        correctAnswer: 'C',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'Синоними калимаи "зебо" кадом аст?',
        options: [
          'A) Хушрӯ',
          'B) Калон',
          'C) Хуб',
          'D) Нек',
        ],
        correctAnswer: 'A',
        type: QuestionType.singleChoice,
      ),
    ];
  }

  static List<MatchingQuestion> getMatchingQuestions() {
    return [
      MatchingQuestion(
        id: 21,
        text: 'Мувофиқатро ёбед:\nA) Адабиёт\nB) Санъат\nC) Илм\nD) Маърифат',
        correctAnswers: {
          'A': 4,
          'B': 5,
          'C': 1,
          'D': 3,
        },
      ),
      MatchingQuestion(
        id: 22,
        text: 'Мувофиқатро ёбед:\nA) Шеър\nB) Насар\nC) Достон\nD) Қасида',
        correctAnswers: {
          'A': 3,
          'B': 5,
          'C': 2,
          'D': 1,
        },
      ),
    ];
  }
}