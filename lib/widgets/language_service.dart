import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'app_language';
  
  // Получить текущий язык
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'tj'; // По умолчанию таджикский
  }
  
  // Сохранить язык
  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}

// Класс для переводов
class AppLocalizations {
  final String languageCode;
  
  AppLocalizations(this.languageCode);
  
  static final Map<String, Map<String, String>> _localizedValues = {
    'welcome': {
      'tj': 'Хуш омадед',
      'ru': 'Добро пожаловать',
    },
    'select_grade': {
      'tj': 'Синфи худро интихоб кунед',
      'ru': 'Выберите свой класс',
    },
    'grade': {
      'tj': 'синф',
      'ru': 'класс',
    },
    'subjects': {
      'tj': 'фанҳо',
      'ru': 'предметов',
    },
    'questions': {
      'tj': 'савол',
      'ru': 'вопросов',
    },
    'books': {
      'tj': 'Китобҳо',
      'ru': 'Книги',
    },
    'take_test': {
      'tj': 'Санҷиш гузаронед',
      'ru': 'Пройти тест',
    },
    'test_by_cluster': {
      'tj': 'Санҷиш аз рӯи кластер',
      'ru': 'Тест по кластеру',
    },
    'profile': {
      'tj': 'Профил',
      'ru': 'Профиль',
    },
    'semester': {
      'tj': 'нимсола',
      'ru': 'семестр',
    },
    'view_book': {
      'tj': 'Китобро кушоед',
      'ru': 'Открыть книгу',
    },
    'answer_key': {
      'tj': 'Калид',
      'ru': 'Ключ',
    },
    'find_your_cluster': {
      'tj': 'Кластери худро ёбед',
      'ru': 'Найти свой кластер',
    },
    'test_description': {
      'tj': 'Саволҳои тасодуфӣ аз ҳамаи фанҳо барои муайян кардани кластери шумо',
      'ru': 'Случайные вопросы из всех предметов для определения вашего кластера',
    },
    'cluster_test_description': {
      'tj': 'Санҷишро дар кластери муайян гузаронед',
      'ru': 'Пройдите тест в определенном кластере',
    },
    'start_test': {
      'tj': 'Оғози санҷиш',
      'ru': 'Начать тест',
    },
    'full_name': {
      'tj': 'Ному насаб',
      'ru': 'ФИО',
    },
    'best_score': {
      'tj': 'Беҳтарин натиҷа',
      'ru': 'Лучший результат',
    },
    'your_cluster': {
      'tj': 'Кластери шумо',
      'ru': 'Ваш кластер',
    },
    'edit_profile': {
      'tj': 'Таҳрир кардан',
      'ru': 'Редактировать',
    },
    'cluster_a': {
      'tj': 'Кластер А',
      'ru': 'Кластер А',
    },
    'cluster_b': {
      'tj': 'Кластер Б',
      'ru': 'Кластер Б',
    },
    'select_cluster': {
      'tj': 'Кластерро интихоб кунед',
      'ru': 'Выберите кластер',
    },
  };
  
  String translate(String key) {
    return _localizedValues[key]?[languageCode] ?? key;
  }
}