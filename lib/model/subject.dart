class Subject {
  final String id;
  final String nameRu;
  final String nameUz;
  final String icon;
  final String color;
  final int totalQuestions;
  final int grade; // 9 или 11

  Subject({
    required this.id,
    required this.nameRu,
    required this.nameUz,
    required this.icon,
    required this.color,
    required this.totalQuestions,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameRu': nameRu,
      'nameUz': nameUz,
      'icon': icon,
      'color': color,
      'totalQuestions': totalQuestions,
      'grade': grade,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      nameRu: map['nameRu'],
      nameUz: map['nameUz'],
      icon: map['icon'],
      color: map['color'],
      totalQuestions: map['totalQuestions'],
      grade: map['grade'],
    );
  }
}