class TestResult {
  final String id;
  final String subjectId;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final DateTime completedAt;
  final int timeSpentSeconds;
  final double percentage;

  TestResult({
    required this.id,
    required this.subjectId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedQuestions,
    required this.completedAt,
    required this.timeSpentSeconds,
  }) : percentage = (correctAnswers / totalQuestions * 100);

  String get grade {
    if (percentage >= 90) return 'Отлично';
    if (percentage >= 75) return 'Хорошо';
    if (percentage >= 60) return 'Удовлетворительно';
    return 'Неудовлетворительно';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'skippedQuestions': skippedQuestions,
      'completedAt': completedAt.toIso8601String(),
      'timeSpentSeconds': timeSpentSeconds,
    };
  }

  factory TestResult.fromMap(Map<String, dynamic> map) {
    return TestResult(
      id: map['id'],
      subjectId: map['subjectId'],
      totalQuestions: map['totalQuestions'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
      skippedQuestions: map['skippedQuestions'],
      completedAt: DateTime.parse(map['completedAt']),
      timeSpentSeconds: map['timeSpentSeconds'],
    );
  }
}