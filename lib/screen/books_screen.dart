import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_cluster/model/book.dart';
import '../services/language_service.dart';
import 'pdf_viewer_screen.dart';
import 'test_screen.dart';

class BooksScreen extends StatefulWidget {
  final int grade;
  final String languageCode;

  const BooksScreen({
    Key? key,
    required this.grade,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  // Группировка книг по кластерам
  Map<int, List<Book>> _groupBooksByCluster() {
    final Map<int, List<Book>> grouped = {};
    final allBooks = BooksData.getBooksByGrade(widget.grade);
    
    // Проходим по всем кластерам (1-5)
    for (int cluster = 1; cluster <= 5; cluster++) {
      final booksInCluster = allBooks
          .where((book) => book.clusters.contains(cluster))
          .toList();
      
      if (booksInCluster.isNotEmpty) {
        grouped[cluster] = booksInCluster;
      }
    }
    
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedBooks = _groupBooksByCluster();
    final clusters = groupedBooks.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: clusters.length,
      itemBuilder: (context, index) {
        final cluster = clusters[index];
        final books = groupedBooks[cluster]!;
        
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: Colors.blue.withOpacity(0.3),
            child: ExpansionTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$cluster',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(
                widget.languageCode == 'tj' 
                    ? 'Кластер $cluster' 
                    : 'Кластер $cluster',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${books.length} ${widget.languageCode == 'tj' ? 'фан' : 'предметов'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              children: books.map((book) => _BookListItem(
                book: book,
                languageCode: widget.languageCode,
              )).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _BookListItem extends StatelessWidget {
  final Book book;
  final String languageCode;

  const _BookListItem({
    required this.book,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем название книги в зависимости от языка
    final bookName = languageCode == 'tj' ? book.nameTj : book.nameRu;
    
    // Получаем путь к PDF в зависимости от языка
    final pdfPath = languageCode == 'tj' ? book.pdfPathTj : book.pdfPathRu;
    final keyPath = languageCode == 'tj' ? book.pdfKeyPathTj : book.pdfKeyPathRu;
    
    final color = Color(int.parse(book.color));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              book.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          bookName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              book.clusterType == 'AB' 
                  ? (languageCode == 'tj' ? 'Кластер А + Б' : 'Кластер А + Б')
                  : (languageCode == 'tj' 
                      ? 'Кластер ${book.clusterType}' 
                      : 'Кластер ${book.clusterType}'),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            if (book.hasTest)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Text(
                    languageCode == 'tj' ? '✓ Тест мавҷуд' : '✓ Тест доступен',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Кнопка "Ключ"
            IconButton(
              icon: const Icon(Icons.key, color: Colors.orange, size: 20),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PdfViewerScreen(
                      pdfPath: keyPath,
                      title: '$bookName - ${languageCode == 'tj' ? 'Калид' : 'Ключ'}',
                    ),
                  ),
                );
              },
              tooltip: languageCode == 'tj' ? 'Калид' : 'Ключ',
            ),
            
            // Кнопка "Тест" (если тест доступен)
            if (book.hasTest)
              IconButton(
                icon: const Icon(Icons.quiz, color: Colors.green, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TestScreen(
                        subjectId: book.id,
                        subjectName: bookName,
                        languageCode: languageCode,
                        questionsCount: 25, grade: 0,
                      ),
                    ),
                  );
                },
                tooltip: languageCode == 'tj' ? 'Тест' : 'Тест',
              ),
            
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PdfViewerScreen(
                pdfPath: pdfPath,
                title: bookName,
                keyPath: keyPath,
              ),
            ),
          );
        },
      ),
    );
  }
}