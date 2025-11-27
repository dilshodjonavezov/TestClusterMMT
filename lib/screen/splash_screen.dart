import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_cluster/widgets/language_service.dart';
import '../services/language_service.dart';
import 'main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _languageCode = 'tj';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final lang = await LanguageService.getLanguage();
    setState(() {
      _languageCode = lang;
    });
  }

  Future<void> _changeLanguage(String newLang) async {
    await LanguageService.setLanguage(newLang);
    setState(() {
      _languageCode = newLang;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(_languageCode);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _changeLanguage('tj'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _languageCode == 'tj' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'TJ',
                              style: TextStyle(
                                color: _languageCode == 'tj' ? Colors.blue : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _changeLanguage('ru'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _languageCode == 'ru' ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'RU',
                              style: TextStyle(
                                color: _languageCode == 'ru' ? Colors.blue : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 60,
                      color: Color(0xFF667EEA),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: const Text(
                    'Test Cluster',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    _languageCode == 'tj' 
                        ? 'Роҳи шумо ба муваффақият'
                        : 'Ваш путь к успеху',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Spacer(),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600),
                  child: Text(
                    localizations.translate('select_grade'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 800),
                  child: _GradeButton(
                    grade: 9,
                    languageCode: _languageCode,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainHomeScreen(grade: 9),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 1000),
                  child: _GradeButton(
                    grade: 11,
                    languageCode: _languageCode,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const MainHomeScreen(grade: 11),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradeButton extends StatelessWidget {
  final int grade;
  final String languageCode;
  final VoidCallback onTap;

  const _GradeButton({
    required this.grade,
    required this.languageCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(languageCode);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$grade',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF667EEA),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$grade ${localizations.translate('grade')}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3436),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF667EEA),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}