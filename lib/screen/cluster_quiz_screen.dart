import 'package:flutter/material.dart';
import 'package:test_cluster/model/Test%20question%20simple.dart';
import 'dart:async';
import 'test_loader.dart';

class ClusterQuizScreen extends StatefulWidget {
  final String cluster;
  final int grade;
  final int clusterNumber;
  final String languageCode;
  final List<Map<String, dynamic>> subjects;

  const ClusterQuizScreen({
    Key? key,
    required this.cluster,
    required this.grade,
    required this.clusterNumber,
    required this.languageCode,
    required this.subjects,
  }) : super(key: key);

  @override
  State<ClusterQuizScreen> createState() => _ClusterQuizScreenState();
}

class _ClusterQuizScreenState extends State<ClusterQuizScreen> {
  int _currentSubjectIndex = 0;
  int _currentQuestionIndex = 0;
  List<Question> _allQuestions = [];
  Map<int, String> _userAnswers = {};
  Timer? _timer;
  int _secondsElapsed = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadAllQuestions() {
    try {
      List<Question> allQuestions = [];
      
      for (var subject in widget.subjects) {
        final questions = TestLoader.loadQuestions(
          grade: widget.grade,
          cluster: widget.cluster,
          clusterNumber: widget.clusterNumber,
          subjectId: subject['id'],
          languageCode: widget.languageCode,
          count: 25,
        );
        allQuestions.addAll(questions);
      }

      setState(() {
        _allQuestions = allQuestions;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading questions: $e');
      setState(() {
        _isLoading = false;
      });
    }
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

  void _answerQuestion(String answer) {
    setState(() {
      _userAnswers[_allQuestions[_currentQuestionIndex].id] = answer;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _allQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        
        // Проверяем смену предмета
        final questionsPerSubject = 25;
        final newSubjectIndex = _currentQuestionIndex ~/ questionsPerSubject;
        if (newSubjectIndex != _currentSubjectIndex) {
          _currentSubjectIndex = newSubjectIndex;
        }
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        
        // Проверяем смену предмета
        final questionsPerSubject = 25;
        final newSubjectIndex = _currentQuestionIndex ~/ questionsPerSubject;
        if (newSubjectIndex != _currentSubjectIndex) {
          _currentSubjectIndex = newSubjectIndex;
        }
      });
    }
  }

  void _finishTest() {
    _timer?.cancel();

    int correct = 0;
    int wrong = 0;
    int skipped = 0;

    for (var question in _allQuestions) {
      final userAnswer = _userAnswers[question.id];
      if (userAnswer == null) {
        skipped++;
      } else if (userAnswer == question.correctAnswer) {
        correct++;
      } else {
        wrong++;
      }
    }

    _showResultDialog(correct, wrong, skipped);
  }

  void _showResultDialog(int correct, int wrong, int skipped) {
    final percentageValue = _allQuestions.isNotEmpty ? (correct / _allQuestions.length * 100) : 0.0;
    final percentage = percentageValue.toStringAsFixed(1);
    String grade = 'Норозӣ';
    Color gradeColor = Colors.red;

    if (percentageValue >= 90) {
      grade = 'Аъло';
      gradeColor = Colors.green;
    } else if (percentageValue >= 75) {
      grade = 'Хуб';
      gradeColor = Colors.blue;
    } else if (percentageValue >= 60) {
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
          children: [
            Container(
              padding: const EdgeInsets.all(20),
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
            _buildStatRow(Icons.check_circle, Colors.green, 'Дуруст', '$correct'),
            _buildStatRow(Icons.cancel, Colors.red, 'Нодуруст', '$wrong'),
            _buildStatRow(Icons.remove_circle, Colors.grey, 'Гузаштанд', '$skipped'),
            _buildStatRow(Icons.timer, Colors.blue, 'Вақт', _formatTime(_secondsElapsed)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(widget.languageCode == 'tj' ? 'Анҷом' : 'Завершить'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _currentSubjectIndex = 0;
                _userAnswers.clear();
                _secondsElapsed = 0;
                _loadAllQuestions();
                _startTimer();
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(widget.languageCode == 'tj' ? 'Аз нав' : 'Заново'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _allQuestions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                widget.languageCode == 'tj'
                    ? 'Боркунии саволҳо...'
                    : 'Загрузка вопросов...',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _allQuestions[_currentQuestionIndex];
    final currentSubject = widget.subjects[_currentSubjectIndex];
    final progress = (_currentQuestionIndex + 1) / _allQuestions.length;
    final questionInSubject = (_currentQuestionIndex % 25) + 1;

    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              widget.languageCode == 'tj' ? 'Бароравӣ?' : 'Выйти?',
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
              _buildHeader(progress, currentSubject, questionInSubject),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildQuestionCard(currentQuestion),
                      const SizedBox(height: 24),
                      _buildAnswerOptions(currentQuestion),
                    ],
                  ),
                ),
              ),
              _buildNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress, Map<String, dynamic> currentSubject, int questionInSubject) {
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
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.languageCode == 'tj'
                          ? currentSubject['nameTj']
                          : currentSubject['nameRu'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.languageCode == 'tj' ? 'Савол' : 'Вопрос'} $questionInSubject/25',
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
          const SizedBox(height: 8),
          Text(
            '${_currentQuestionIndex + 1}/${_allQuestions.length}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          question.text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(Question question) {
    final userAnswer = _userAnswers[question.id];

    return Column(
      children: List.generate(question.options.length, (index) {
        final option = question.options[index];
        final isSelected = userAnswer == option[0];

        return GestureDetector(
          onTap: () => _answerQuestion(option[0]),
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
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blue : Colors.white,
                    border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: 2),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
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

  Widget _buildNavigationBar() {
    final isLastQuestion = _currentQuestionIndex == _allQuestions.length - 1;

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
          if (_currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _previousQuestion,
                icon: const Icon(Icons.arrow_back),
                label: Text(widget.languageCode == 'tj' ? 'Пеш' : 'Назад'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          if (_currentQuestionIndex > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: isLastQuestion ? _finishTest : _nextQuestion,
              icon: Icon(isLastQuestion ? Icons.check : Icons.arrow_forward),
              label: Text(
                isLastQuestion
                    ? (widget.languageCode == 'tj' ? 'Анҷом' : 'Завершить')
                    : (widget.languageCode == 'tj' ? 'Минбаъда' : 'Далее'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastQuestion ? Colors.green : Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}