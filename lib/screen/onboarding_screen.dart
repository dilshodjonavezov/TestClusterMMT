import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_cluster/custom/app_theme.dart';
import 'package:test_cluster/screen/gradle_selection_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.quiz_rounded,
      title: 'Тысячи вопросов',
      description: 'Более 1000 вопросов по каждому предмету для полной подготовки',
      color: AppTheme.primaryColor,
    ),
    OnboardingPage(
      icon: Icons.language_rounded,
      title: 'Два языка',
      description: 'Выбирай русский или узбекский язык для прохождения тестов',
      color: AppTheme.secondaryColor,
    ),
    OnboardingPage(
      icon: Icons.analytics_rounded,
      title: 'Отслеживай прогресс',
      description: 'Смотри статистику и анализируй свои результаты',
      color: AppTheme.accentColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GradeSelectionScreen()),
      );
    }
  }

  void _skip() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const GradeSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: _currentPage < _pages.length - 1
                  ? TextButton(
                      onPressed: _skip,
                      child: const Text(
                        'Пропустить',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    )
                  : const SizedBox(height: 48),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            _buildIndicators(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage < _pages.length - 1 ? 'Далее' : 'Начать',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: page.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                page.icon,
                size: 100,
                color: page.color,
              ),
            ),
          ),
          const SizedBox(height: 50),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: Text(
              page.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            child: Text(
              page.description,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? _pages[index].color
                : AppTheme.textSecondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}