import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_cluster/model/task_quations_model.dart';
import 'dart:async';

class TestScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;
  final String languageCode;
  final int questionsCount;

  const TestScreen({
    Key? key,
    required this.subjectId,
    required this.subjectName,
    required this.languageCode,
    this.questionsCount = 25, required int grade,
  }) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<TestQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  Map<int, dynamic> _userAnswers = {}; // questionId -> answer
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isTestCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadQuestions() {
    setState(() {
      _questions = TestQuestionsData.generateRandomTest(
        subjectId: widget.subjectId,
        language: widget.languageCode,
        questionsCount: widget.questionsCount,
      );
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _secondsElapsed++;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _answerQuestion(dynamic answer) {
    setState(() {
      _userAnswers[_questions[_currentQuestionIndex].id] = answer;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _finishTest() {
    _timer?.cancel();
    
    // Подсчёт результатов
    int correctAnswers = 0;
    int wrongAnswers = 0;
    int skippedQuestions = 0;

    for (var question in _questions) {
      final userAnswer = _userAnswers[question.id];
      
      if (userAnswer == null) {
        skippedQuestions++;
      } else {
        bool isCorrect = false;
        
        if (question.type == QuestionType.singleChoice) {
          isCorrect = userAnswer == question.correctAnswer;
        } else if (question.type == QuestionType.matching) {
          // Проверка соответствия
          final correctMap = question.correctAnswer as Map<String, int>;
          final userMap = userAnswer as Map<String, int>;
          
          isCorrect = correctMap.entries.every((entry) {
            return userMap[entry.key] == entry.value;
          });
        }
        
        if (isCorrect) {
          correctAnswers++;
        } else {
          wrongAnswers++;
        }
      }
    }

    setState(() {
      _isTestCompleted = true;
    });

    // Показать результаты
    _showResultDialog(correctAnswers, wrongAnswers, skippedQuestions);
  }

  void _showResultDialog(int correct, int wrong, int skipped) {
    final percentageDouble = (_questions.isNotEmpty) ? (correct / _questions.length * 100) : 0.0;
    final percentage = percentageDouble.toStringAsFixed(1);
    String grade = 'Норозӣ';
    Color gradeColor = Colors.red;
    
    if (percentageDouble >= 90) {
      grade = 'Аъло';
      gradeColor = Colors.green;
    } else if (percentageDouble >= 75) {
      grade = 'Хуб';
      gradeColor = Colors.blue;
    } else if (percentageDouble >= 60) {
      grade = 'Қаноатбахш';
      gradeColor = Colors.orange;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: gradeColor, size: 32),
            const SizedBox(width: 12),
            Text(
              widget.languageCode == 'tj' ? 'Натиҷа' : 'Результат',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Процент и оценка
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: gradeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: gradeColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: gradeColor,
                    ),
                  ),
                  Text(
                    grade,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: gradeColor,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Статистика
            _buildStatRow(
              icon: Icons.check_circle,
              color: Colors.green,
              label: widget.languageCode == 'tj' ? 'Дуруст' : 'Правильно',
              value: '$correct',
            ),
            _buildStatRow(
              icon: Icons.cancel,
              color: Colors.red,
              label: widget.languageCode == 'tj' ? 'Нодуруст' : 'Неправильно',
              value: '$wrong',
            ),
            _buildStatRow(
              icon: Icons.remove_circle,
              color: Colors.grey,
              label: widget.languageCode == 'tj' ? 'Гузаштанд' : 'Пропущено',
              value: '$skipped',
            ),
            _buildStatRow(
              icon: Icons.timer,
              color: Colors.blue,
              label: widget.languageCode == 'tj' ? 'Вақт' : 'Время',
              value: _formatTime(_secondsElapsed),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Вернуться на экран книг
            },
            child: Text(
              widget.languageCode == 'tj' ? 'Анҷом' : 'Завершить',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Перезапустить тест
              setState(() {
                _currentQuestionIndex = 0;
                _userAnswers.clear();
                _secondsElapsed = 0;
                _isTestCompleted = false;
                _loadQuestions();
                _startTimer();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text(
              widget.languageCode == 'tj' ? 'Аз нав' : 'Заново',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;

    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              widget.languageCode == 'tj' 
                  ? 'Бароравӣ аз тест?' 
                  : 'Выйти из теста?',
            ),
            content: Text(
              widget.languageCode == 'tj'
                  ? 'Ҷавобҳои шумо гум мешаванд.'
                  : 'Ваши ответы будут потеряны.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(widget.languageCode == 'tj' ? 'Не' : 'Нет'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(widget.languageCode == 'tj' ? 'Ҳа' : 'Да'),
              ),
            ],
          ),
        );
        return result ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Заголовок с прогрессом
              _buildHeader(progress),
              
              // Вопрос
              Expanded(
                child: FadeIn(
                  key: ValueKey(_currentQuestionIndex),
                  duration: const Duration(milliseconds: 300),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildQuestionCard(currentQuestion),
                        const SizedBox(height: 24),
                        _buildAnswerOptions(currentQuestion),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Навигация
              _buildNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subjectName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.languageCode == 'tj' ? 'Савол' : 'Вопрос'} ${_currentQuestionIndex + 1} ${widget.languageCode == 'tj' ? 'аз' : 'из'} ${_questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(_secondsElapsed),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(TestQuestion question) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: question.type == QuestionType.singleChoice
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    question.type == QuestionType.singleChoice
                        ? (widget.languageCode == 'tj' ? 'Як ҷавоб' : 'Один ответ')
                        : (widget.languageCode == 'tj' ? 'Мувофиқат' : 'Соответствие'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: question.type == QuestionType.singleChoice
                          ? Colors.blue
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(TestQuestion question) {
    if (question.type == QuestionType.singleChoice) {
      return _buildSingleChoiceOptions(question);
    } else {
      return _buildMatchingOptions(question);
    }
  }

  Widget _buildSingleChoiceOptions(TestQuestion question) {
    final userAnswer = _userAnswers[question.id];
    
    return Column(
      children: List.generate(question.options.length, (index) {
        final isSelected = userAnswer == index;
        
        return GestureDetector(
          onTap: () => _answerQuestion(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blue : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.options[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMatchingOptions(TestQuestion question) {
    // TODO: Реализовать интерфейс для вопросов на соответствие
    return Center(
      child: Text(
        widget.languageCode == 'tj'
            ? 'Саволҳои мувофиқат дар ояндаи наздик...'
            : 'Вопросы на соответствие скоро будут доступны...',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildNavigationBar() {
    final isAnswered = _userAnswers.containsKey(_questions[_currentQuestionIndex].id);
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Кнопка "Назад"
          if (_currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _previousQuestion,
                icon: const Icon(Icons.arrow_back),
                label: Text(
                  widget.languageCode == 'tj' ? 'Пеш' : 'Назад',
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          
          if (_currentQuestionIndex > 0) const SizedBox(width: 12),
          
          // Кнопка "Далее" или "Завершить"
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: isLastQuestion ? _finishTest : _nextQuestion,
              icon: Icon(isLastQuestion ? Icons.check : Icons.arrow_forward),
              label: Text(
                isLastQuestion
                    ? (widget.languageCode == 'tj' ? 'Анҷом додан' : 'Завершить')
                    : (widget.languageCode == 'tj' ? 'Минбаъда' : 'Далее'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastQuestion ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}