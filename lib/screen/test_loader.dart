
import 'package:test_cluster/model/Test%20question%20simple.dart';
import 'package:test_cluster/test_data/grade_11_cluster_A/russian/cluster_1/matematika.dart';
import 'package:test_cluster/test_data/grade_11_cluster_A/russian/cluster_1/zaboni_tojiki.dart';
import 'package:test_cluster/test_data/grade_11_cluster_A/tajik/cluster_1/matematika.dart';
import 'package:test_cluster/test_data/grade_11_cluster_A/tajik/cluster_1/zaboni_tojiki.dart';

class TestLoader {
  static List<Question> loadQuestions({
    required int grade,
    required String cluster,
    required int clusterNumber,
    required String subjectId,
    required String languageCode,
    required int count,
  }) {
    try {
      List<Question> allQuestions = [];
      
      // Загружаем вопросы из соответствующего класса
      if (grade == 11 && cluster == 'A') {
        if (clusterNumber == 1) {
          if (subjectId == 'zaboni_tojiki') {
            if (languageCode == 'tj') {
              allQuestions = ZaboniTojikiCluster1Tajik.getSingleChoiceQuestions();
            } else {
              allQuestions = ZaboniTojikiCluster1Russian.getSingleChoiceQuestions();
            }
          } else if (subjectId == 'matematika') {
            if (languageCode == 'tj') {
              allQuestions = MatematikaCluster1Tajik.getSingleChoiceQuestions();
            } else {
              allQuestions = MatematikaCluster1Russian.getSingleChoiceQuestions();
            }
          // } else if (subjectId == 'ximiya') {
          //   if (languageCode == 'tj') {
          //     allQuestions = XimiyaCluster1Tajik.getSingleChoiceQuestions();
          //   } else {
          //     allQuestions = XimiyaCluster1Russian.getSingleChoiceQuestions();
          //   }
          // } else if (subjectId == 'fizika') {
          //   if (languageCode == 'tj') {
          //     allQuestions = FizikaCluster1Tajik.getSingleChoiceQuestions();
          //   } else {
          //     allQuestions = FizikaCluster1Russian.getSingleChoiceQuestions();
          //   }
          }
        }
        // TODO: Добавьте остальные кластеры и предметы
      }
      
      // Перемешиваем и берём нужное количество
      allQuestions.shuffle();
      return allQuestions.take(count).toList();
    } catch (e) {
      print('Error loading questions: $e');
      return [];
    }
  }
}