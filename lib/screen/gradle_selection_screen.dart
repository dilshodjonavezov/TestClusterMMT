import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_cluster/custom/app_theme.dart';
import 'package:test_cluster/widgets/home_screen.dart';

class GradeSelectionScreen extends StatelessWidget {
  const GradeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  'Выбери свой класс',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                child: const Text(
                  'Выбери класс для начала тестирования',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                child: _GradeCard(
                  grade: 9,
                  subjectsCount: 20,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(grade: 9),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 600),
                child: _GradeCard(
                  grade: 11,
                  subjectsCount: 27,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(grade: 11),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradeCard extends StatelessWidget {
  final int grade;
  final int subjectsCount;
  final Gradient gradient;
  final VoidCallback onTap;

  const _GradeCard({
    required this.grade,
    required this.subjectsCount,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '$grade',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'класс',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$subjectsCount предметов',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1000+ вопросов',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
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