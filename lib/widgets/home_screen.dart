import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:test_cluster/custom/app_theme.dart';
import 'package:test_cluster/model/subject.dart';

class HomeScreen extends StatefulWidget {
  final int grade;

  const HomeScreen({Key? key, required this.grade}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedLanguage = 'ru'; // ru или uz
  
  // Временные данные предметов (потом заменим на данные из БД)
  late List<Subject> _subjects;

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _loadSubjects() {
    // Это временные данные для демонстрации UI
    _subjects = [
      Subject(
        id: '1',
        nameRu: 'Математика',
        nameUz: 'Matematika',
        icon: '📐',
        color: '0xFF6C63FF',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '2',
        nameRu: 'Физика',
        nameUz: 'Fizika',
        icon: '⚛️',
        color: '0xFF4CAF50',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '3',
        nameRu: 'Химия',
        nameUz: 'Kimyo',
        icon: '🧪',
        color: '0xFFFF6B6B',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '4',
        nameRu: 'Биология',
        nameUz: 'Biologiya',
        icon: '🧬',
        color: '0xFF00B894',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '5',
        nameRu: 'История',
        nameUz: 'Tarix',
        icon: '📜',
        color: '0xFFFDCB6E',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '6',
        nameRu: 'География',
        nameUz: 'Geografiya',
        icon: '🌍',
        color: '0xFF74B9FF',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '7',
        nameRu: 'Английский',
        nameUz: 'Ingliz tili',
        icon: '🇬🇧',
        color: '0xFFE17055',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
      Subject(
        id: '8',
        nameRu: 'Литература',
        nameUz: 'Adabiyot',
        icon: '📚',
        color: '0xFFA29BFE',
        totalQuestions: 1000,
        grade: widget.grade,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            '${widget.grade} класс',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 200),
                          child: const Text(
                            'Выбери предмет',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _selectedLanguage = 'ru'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _selectedLanguage == 'ru' 
                                  ? Colors.white 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'RU',
                              style: TextStyle(
                                color: _selectedLanguage == 'ru' 
                                    ? AppTheme.primaryColor 
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => _selectedLanguage = 'uz'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _selectedLanguage == 'uz' 
                                  ? Colors.white 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'UZ',
                              style: TextStyle(
                                color: _selectedLanguage == 'uz' 
                                    ? AppTheme.primaryColor 
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 100 * index),
                    child: _SubjectCard(
                      subject: _subjects[index],
                      language: _selectedLanguage,
                    ),
                  );
                },
                childCount: _subjects.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Subject subject;
  final String language;

  const _SubjectCard({
    required this.subject,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(subject.color));
    
    return GestureDetector(
      onTap: () {
        // Здесь будет переход на экран теста
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Открываем ${language == 'ru' ? subject.nameRu : subject.nameUz}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.softShadow,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        subject.icon,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    language == 'ru' ? subject.nameRu : subject.nameUz,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.quiz_rounded,
                        size: 16,
                        color: color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${subject.totalQuestions} вопросов',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}