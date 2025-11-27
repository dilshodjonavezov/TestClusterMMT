// test_data/grade_11_cluster_A/russian/cluster_1/zaboni_tojiki.dart

import 'package:test_cluster/model/Test%20question%20simple.dart';


class ZaboniTojikiCluster1Russian {
  static List<Question> getSingleChoiceQuestions() {
    return [
      Question(
        id: 1,
        text: 'В каком предложении слово "бахт" выражает значение "счастье"?',
        options: [
          'A) Моё счастье пришло в один момент',
          'B) Пусть твоё счастье будет хорошим',
          'C) В этом деле мне не везёт',
          'D) Счастье быть счастливым',
        ],
        correctAnswer: 'D',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 2,
        text: 'Какое слово в предложении имеет функцию определения?',
        options: [
          'A) Большой дом',
          'B) Новая книга',
          'C) Высокое дерево',
          'D) Хороший человек',
        ],
        correctAnswer: 'C',
        type: QuestionType.singleChoice,
      ),
      Question(
        id: 3,
        text: 'Синоним слова "красивый"?',
        options: [
          'A) Прекрасный',
          'B) Большой',
          'C) Хороший',
          'D) Добрый',
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
        text: 'Установите соответствие:\nA) Литература\nB) Искусство\nC) Наука\nD) Образование',
        correctAnswers: {
          'A': 4,
          'B': 5,
          'C': 1,
          'D': 3,
        },
      ),
      MatchingQuestion(
        id: 22,
        text: 'Установите соответствие:\nA) Стих\nB) Проза\nC) Эпос\nD) Ода',
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