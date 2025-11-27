import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cluster_quiz_screen.dart';

class ClusterTestScreen extends StatefulWidget {
  final String languageCode;

  const ClusterTestScreen({
    Key? key,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<ClusterTestScreen> createState() => _ClusterTestScreenState();
}

class _ClusterTestScreenState extends State<ClusterTestScreen> {
  String? _selectedCluster;
  int? _selectedGrade;

  @override
  void initState() {
    super.initState();
    _loadCluster();
  }

  Future<void> _loadCluster() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCluster = prefs.getString('selected_cluster');
      _selectedGrade = prefs.getInt('selected_grade');
    });
  }

  Future<void> _saveCluster(String cluster, int grade) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_cluster', cluster);
    await prefs.setInt('selected_grade', grade);
    setState(() {
      _selectedCluster = cluster;
      _selectedGrade = grade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedCluster == null
          ? _buildClusterSelection()
          : _buildClustersList(),
    );
  }

  Widget _buildClusterSelection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.languageCode == 'tj'
                  ? 'Кластери худро интихоб кунед'
                  : 'Выберите свой кластер',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildClusterCard('A', 11, '🎓'),
            const SizedBox(height: 20),
            _buildClusterCard('B', 9, '📚'),
          ],
        ),
      ),
    );
  }

  Widget _buildClusterCard(String cluster, int grade, String icon) {
    return GestureDetector(
      onTap: () => _saveCluster(cluster, grade),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: cluster == 'A'
                ? [Color(0xFF667EEA), Color(0xFF764BA2)]
                : [Color(0xFFF093FB), Color(0xFFF5576C)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              widget.languageCode == 'tj'
                  ? 'Кластер $cluster'
                  : 'Кластер $cluster',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.languageCode == 'tj'
                  ? 'Синфи $grade-ум'
                  : '$grade класс',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClustersList() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.languageCode == 'tj'
                  ? 'Кластер $_selectedCluster'
                  : 'Кластер $_selectedCluster',
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _selectedCluster == 'A'
                      ? [Color(0xFF667EEA), Color(0xFF764BA2)]
                      : [Color(0xFFF093FB), Color(0xFFF5576C)],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      widget.languageCode == 'tj'
                          ? 'Кластерро иваз кунед?'
                          : 'Изменить кластер?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(widget.languageCode == 'tj' ? 'Не' : 'Нет'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(widget.languageCode == 'tj' ? 'Ҳа' : 'Да'),
                      ),
                    ],
                  ),
                );

                if (result == true) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('selected_cluster');
                  await prefs.remove('selected_grade');
                  setState(() {
                    _selectedCluster = null;
                    _selectedGrade = null;
                  });
                }
              },
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final clusterNumber = index + 1;
                return _buildClusterCard2(clusterNumber);
              },
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClusterCard2(int clusterNumber) {
    final subjects = _getSubjectsForCluster(clusterNumber);
    
    if (subjects.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ClusterQuizScreen(
                cluster: _selectedCluster!,
                grade: _selectedGrade!,
                clusterNumber: clusterNumber,
                languageCode: widget.languageCode,
                subjects: subjects,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '$clusterNumber',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.languageCode == 'tj'
                              ? 'Кластер $clusterNumber'
                              : 'Кластер $clusterNumber',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${subjects.length} ${widget.languageCode == 'tj' ? 'фан' : 'предмета'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: subjects.map((subject) {
                  return Text(
                    subject['icon'],
                    style: const TextStyle(fontSize: 24),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Text(
                  widget.languageCode == 'tj'
                      ? '${subjects.length * 25} савол'
                      : '${subjects.length * 25} вопросов',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSubjectsForCluster(int clusterNumber) {
    if (_selectedCluster == 'A' && _selectedGrade == 11) {
      return _getGrade11ClusterASubjects(clusterNumber);
    } else if (_selectedCluster == 'B' && _selectedGrade == 9) {
      return _getGrade9ClusterBSubjects(clusterNumber);
    }
    return [];
  }

  List<Map<String, dynamic>> _getGrade11ClusterASubjects(int cluster) {
    switch (cluster) {
      case 1:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'matematika', 'nameTj': 'Математика', 'nameRu': 'Математика', 'icon': '📐'},
          {'id': 'ximiya', 'nameTj': 'Химия', 'nameRu': 'Химия', 'icon': '🧪'},
          {'id': 'fizika', 'nameTj': 'Физика', 'nameRu': 'Физика', 'icon': '⚛️'},
        ];
      case 2:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'matematika', 'nameTj': 'Математика', 'nameRu': 'Математика', 'icon': '📐'},
          {'id': 'geografiya', 'nameTj': 'Ҷуғрофия', 'nameRu': 'География', 'icon': '🌍'},
        ];
      case 3:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'tarix', 'nameTj': 'Таърих', 'nameRu': 'История', 'icon': '📜'},
          {'id': 'adabiyoti_tojik', 'nameTj': 'Адабиёти тоҷик', 'nameRu': 'Таджикская литература', 'icon': '📖'},
        ];
      case 4:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'tarix', 'nameTj': 'Таърих', 'nameRu': 'История', 'icon': '📜'},
          {'id': 'xuquq', 'nameTj': 'Ҳуқуқ', 'nameRu': 'Право', 'icon': '⚖️'},
        ];
      case 5:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'biologiya', 'nameTj': 'Биология', 'nameRu': 'Биология', 'icon': '🧬'},
          {'id': 'ximiya', 'nameTj': 'Химия', 'nameRu': 'Химия', 'icon': '🧪'},
          {'id': 'fizika', 'nameTj': 'Физика', 'nameRu': 'Физика', 'icon': '⚛️'},
        ];
      default:
        return [];
    }
  }

  List<Map<String, dynamic>> _getGrade9ClusterBSubjects(int cluster) {
    switch (cluster) {
      case 1:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'matematika', 'nameTj': 'Математика', 'nameRu': 'Математика', 'icon': '📐'},
          {'id': 'fizika', 'nameTj': 'Физика', 'nameRu': 'Физика', 'icon': '⚛️'},
        ];
      case 2:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'matematika', 'nameTj': 'Математика', 'nameRu': 'Математика', 'icon': '📐'},
          {'id': 'geografiya', 'nameTj': 'Ҷуғрофия', 'nameRu': 'География', 'icon': '🌍'},
        ];
      case 3:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'adabiyoti_tojik', 'nameTj': 'Адабиёти тоҷик', 'nameRu': 'Таджикская литература', 'icon': '📖'},
          {'id': 'zaboni_rus', 'nameTj': 'Забони русӣ', 'nameRu': 'Русский язык', 'icon': '🇷🇺'},
        ];
      case 4:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'tarix', 'nameTj': 'Таърих', 'nameRu': 'История', 'icon': '📜'},
        ];
      case 5:
        return [
          {'id': 'zaboni_tojiki', 'nameTj': 'Забони тоҷикӣ', 'nameRu': 'Таджикский язык', 'icon': '📚'},
          {'id': 'biologiya', 'nameTj': 'Биология', 'nameRu': 'Биология', 'icon': '🧬'},
          {'id': 'ximiya', 'nameTj': 'Химия', 'nameRu': 'Химия', 'icon': '🧪'},
        ];
      default:
        return [];
    }
  }
}