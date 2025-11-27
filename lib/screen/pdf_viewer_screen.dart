import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath;
  final String title;
  final String? keyPath;

  const PdfViewerScreen({
    Key? key,
    required this.pdfPath,
    required this.title,
    this.keyPath,
  }) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  int _currentPage = 0;
  int _totalPages = 0;

  void _openAnswerKey() {
    if (widget.keyPath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PdfViewerScreen(
            pdfPath: widget.keyPath!,
            title: '${widget.title} - Калид',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (_totalPages > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '$_currentPage/$_totalPages',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SfPdfViewer.asset(
        widget.pdfPath,
        controller: _pdfViewerController,
        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
          setState(() {
            _totalPages = details.document.pages.count;
            _currentPage = 1;
          });
        },
        onPageChanged: (PdfPageChangedDetails details) {
          setState(() {
            _currentPage = details.newPageNumber;
          });
        },
      ),
      floatingActionButton: widget.keyPath != null
          ? FloatingActionButton.extended(
              onPressed: _openAnswerKey,
              icon: const Icon(Icons.key),
              label: const Text('Калид'),
              backgroundColor: Colors.orange,
            )
          : null,
    );
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }
}