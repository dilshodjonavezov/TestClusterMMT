import 'package:flutter/material.dart';
import 'package:test_cluster/widgets/language_service.dart';
import '../services/language_service.dart';
import 'books_screen.dart';
import 'test_screen.dart';
import 'cluster_test_screen.dart';
import 'profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  final int grade;

  const MainHomeScreen({Key? key, required this.grade}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
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
    
    final List<Widget> screens = [
      BooksScreen(grade: widget.grade, languageCode: _languageCode),
      TestScreen(grade: widget.grade, languageCode: _languageCode, subjectId: '', subjectName: '',),
      ClusterTestScreen(languageCode: _languageCode),
      ProfileScreen(languageCode: _languageCode),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? localizations.translate('books') :
          _currentIndex == 1 ? localizations.translate('take_test') :
          _currentIndex == 2 ? localizations.translate('test_by_cluster') :
          localizations.translate('profile'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
                          color: _languageCode == 'tj' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'TJ',
                          style: TextStyle(
                            color: _languageCode == 'tj' ? Colors.white : Colors.black,
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
                          color: _languageCode == 'ru' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'RU',
                          style: TextStyle(
                            color: _languageCode == 'ru' ? Colors.white : Colors.black,
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
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: localizations.translate('books'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.quiz),
            label: localizations.translate('take_test'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: localizations.translate('test_by_cluster'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.translate('profile'),
          ),
        ],
      ),
    );
  }
}