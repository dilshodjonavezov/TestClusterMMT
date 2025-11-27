class Question {
  final String id;
  final String subjectId;
  final String questionTextRu;
  final String questionTextUz;
  final List<String> optionsRu;
  final List<String> optionsUz;
  final int correctAnswerIndex;
  final String? imageUrl;
  final String difficulty; // easy, medium, hard

  Question({
    required this.id,
    required this.subjectId,
    required this.questionTextRu,
    required this.questionTextUz,
    required this.optionsRu,
    required this.optionsUz,
    required this.correctAnswerIndex,
    this.imageUrl,
    this.difficulty = 'medium',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'questionTextRu': questionTextRu,
      'questionTextUz': questionTextUz,
      'optionsRu': optionsRu.join('|||'),
      'optionsUz': optionsUz.join('|||'),
      'correctAnswerIndex': correctAnswerIndex,
      'imageUrl': imageUrl,
      'difficulty': difficulty,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      subjectId: map['subjectId'],
      questionTextRu: map['questionTextRu'],
      questionTextUz: map['questionTextUz'],
      optionsRu: (map['optionsRu'] as String).split('|||'),
      optionsUz: (map['optionsUz'] as String).split('|||'),
      correctAnswerIndex: map['correctAnswerIndex'],
      imageUrl: map['imageUrl'],
      difficulty: map['difficulty'] ?? 'medium',
    );
  }
}