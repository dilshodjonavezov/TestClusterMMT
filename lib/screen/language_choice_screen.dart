import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChoiceScreen extends StatefulWidget {
  final String languageCode;
  final int grade;
  final String cluster;
  final int clusterNumber;

  const LanguageChoiceScreen({
    Key? key,
    required this.languageCode,
    required this.grade,
    required this.cluster,
    required this.clusterNumber,
  }) : super(key: key);

  @override
  State<LanguageChoiceScreen> createState() => _LanguageChoiceScreenState();
}

class _LanguageChoiceScreenState extends State<LanguageChoiceScreen> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'language_choice_${widget.grade}_${widget.cluster}_${widget.clusterNumber}';
    setState(() {
      _selectedLanguage = prefs.getString(key);
    });
  }

  Future<void> _saveLanguageChoice(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'language_choice_${widget.grade}_${widget.cluster}_${widget.clusterNumber}';
    await prefs.setString(key, language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.languageCode == 'tj'
              ? 'Забонро интихоб кунед'
              : 'Выберите язык',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.languageCode == 'tj'
                  ? 'Кадом забонро барои санҷиш интихоб мекунед?'
                  : 'Какой язык выбираете для тестирования?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildLanguageOption('english', 'Английский', '🇬🇧'),
            _buildLanguageOption('german', 'Немецкий', '🇩🇪'),
            _buildLanguageOption('french', 'Французский', '🇫🇷'),
            _buildLanguageOption('arabic', 'Арабский', '🕌'),
            const Spacer(),
            if (_selectedLanguage != null)
              ElevatedButton(
                onPressed: () {
                  // TODO: Открыть тест выбранного языка
                  Navigator.pop(context, _selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.languageCode == 'tj'
                      ? 'Давом додан'
                      : 'Продолжить',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String id, String name, String icon) {
    final isSelected = _selectedLanguage == id;

    return GestureDetector(
      onTap: () => _saveLanguageChoice(id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.blue, size: 28),
          ],
        ),
      ),
    );
  }
}