class Book {
  final String id;
  final String nameTj;
  final String nameRu;
  final String pdfPathTj;  // PDF на таджикском
  final String pdfPathRu;  // PDF на русском
  final String pdfKeyPathTj;  // Ключ на таджикском
  final String pdfKeyPathRu;  // Ключ на русском
  final int grade;
  final List<int> clusters; // В каких кластерах есть этот предмет
  final String clusterType; // A, B или AB
  final String icon;
  final String color;
  final bool hasTest; // Есть ли тест по этому предмету

  Book({
    required this.id,
    required this.nameTj,
    required this.nameRu,
    required this.pdfPathTj,
    required this.pdfPathRu,
    required this.pdfKeyPathTj,
    required this.pdfKeyPathRu,
    required this.grade,
    required this.clusters,
    required this.clusterType,
    required this.icon,
    required this.color,
    this.hasTest = false,
  });
}

// Класс с данными всех книг
class BooksData {
  // ════════════════════════════════════════════════════════════════
  // 9 КЛАСС
  // ════════════════════════════════════════════════════════════════
  static List<Book> getGrade9Books() {
    return [
      // ────────────────────────────────────────────────────────────
      // ЗАБОНИ ТОҶИКӢ - Присутствует во ВСЕХ кластерах (AB)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_tojiki',
        nameTj: 'Забони тоҷикӣ',
        nameRu: 'Таджикский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_tojiki_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_tojiki_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_tojiki_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_tojiki_9_key_ru.pdf',
        grade: 9,
        clusters: [1, 2, 3, 4, 5], // Во всех кластерах
        clusterType: 'AB',
        icon: '📚',
        color: '0xFF6C63FF',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // МАТЕМАТИКА - Кластер 1, 2 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_matematika',
        nameTj: 'Математика',
        nameRu: 'Математика',
        pdfPathTj: 'assets/books/tajik/matematika_9.pdf',
        pdfPathRu: 'assets/books/russian/matematika_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/matematika_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/matematika_9_key_ru.pdf',
        grade: 9,
        clusters: [1, 2],
        clusterType: 'A',
        icon: '📐',
        color: '0xFF4CAF50',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ФИЗИКА - Кластер 1 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_fizika',
        nameTj: 'Физика',
        nameRu: 'Физика',
        pdfPathTj: 'assets/books/tajik/fizika_9.pdf',
        pdfPathRu: 'assets/books/russian/fizika_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/fizika_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/fizika_9_key_ru.pdf',
        grade: 9,
        clusters: [1],
        clusterType: 'A',
        icon: '⚛️',
        color: '0xFFFF6B6B',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ГЕОГРАФИЯ - Кластер 2 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_geografiya',
        nameTj: 'Ҷуғрофия',
        nameRu: 'География',
        pdfPathTj: 'assets/books/tajik/geografiya_9.pdf',
        pdfPathRu: 'assets/books/russian/geografiya_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/geografiya_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/geografiya_9_key_ru.pdf',
        grade: 9,
        clusters: [2],
        clusterType: 'B',
        icon: '🌍',
        color: '0xFF74B9FF',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // АДАБИЁТИ ТОҶИК - Кластер 3 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_adabiyot',
        nameTj: 'Адабиёти тоҷик',
        nameRu: 'Таджикская литература',
        pdfPathTj: 'assets/books/tajik/adabiyoti_tojik_9.pdf',
        pdfPathRu: 'assets/books/russian/adabiyoti_tojik_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/adabiyoti_tojik_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/adabiyoti_tojik_9_key_ru.pdf',
        grade: 9,
        clusters: [3],
        clusterType: 'B',
        icon: '📖',
        color: '0xFFA29BFE',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ЗАБОНИ РУСӢ - Кластер 3 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_rus',
        nameTj: 'Забони русӣ',
        nameRu: 'Русский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_rus_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_rus_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_rus_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_rus_9_key_ru.pdf',
        grade: 9,
        clusters: [3],
        clusterType: 'B',
        icon: '🇷🇺',
        color: '0xFFE17055',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ЯЗЫКИ НА ВЫБОР - Кластер 3, 4 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      
      // Английский
      Book(
        id: '9_anglisi',
        nameTj: 'Забони англисӣ',
        nameRu: 'Английский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_anglisi_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_anglisi_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_anglisi_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_anglisi_9_key_ru.pdf',
        grade: 9,
        clusters: [3, 4],
        clusterType: 'B',
        icon: '🇬🇧',
        color: '0xFF0984E3',
        hasTest: false,
      ),
      
      // Немецкий
      Book(
        id: '9_nemisi',
        nameTj: 'Забони немисӣ',
        nameRu: 'Немецкий язык',
        pdfPathTj: 'assets/books/tajik/zaboni_nemisi_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_nemisi_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_nemisi_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_nemisi_9_key_ru.pdf',
        grade: 9,
        clusters: [3, 4],
        clusterType: 'B',
        icon: '🇩🇪',
        color: '0xFFFDCB6E',
        hasTest: false,
      ),
      
      // Французский
      Book(
        id: '9_fransuzi',
        nameTj: 'Забони франсузӣ',
        nameRu: 'Французский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_fransuzi_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_fransuzi_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_fransuzi_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_fransuzi_9_key_ru.pdf',
        grade: 9,
        clusters: [3, 4],
        clusterType: 'B',
        icon: '🇫🇷',
        color: '0xFF00B894',
        hasTest: false,
      ),
      
      // Арабский
      Book(
        id: '9_arabi',
        nameTj: 'Забони арабӣ',
        nameRu: 'Арабский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_arabi_9.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_arabi_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_arabi_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_arabi_9_key_ru.pdf',
        grade: 9,
        clusters: [3, 4],
        clusterType: 'B',
        icon: '🕌',
        color: '0xFFD63031',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ТАЪРИХ - Кластер 4 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_tarix',
        nameTj: 'Таърих',
        nameRu: 'История',
        pdfPathTj: 'assets/books/tajik/tarix_9.pdf',
        pdfPathRu: 'assets/books/russian/tarix_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/tarix_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/tarix_9_key_ru.pdf',
        grade: 9,
        clusters: [4],
        clusterType: 'B',
        icon: '📜',
        color: '0xFF6C5CE7',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // БИОЛОГИЯ - Кластер 5 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_biologiya',
        nameTj: 'Биология',
        nameRu: 'Биология',
        pdfPathTj: 'assets/books/tajik/biologiya_9.pdf',
        pdfPathRu: 'assets/books/russian/biologiya_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/biologiya_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/biologiya_9_key_ru.pdf',
        grade: 9,
        clusters: [5],
        clusterType: 'A',
        icon: '🧬',
        color: '0xFF00B894',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ХИМИЯ - Кластер 5 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '9_ximiya',
        nameTj: 'Химия',
        nameRu: 'Химия',
        pdfPathTj: 'assets/books/tajik/ximiya_9.pdf',
        pdfPathRu: 'assets/books/russian/ximiya_9_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/ximiya_9_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/ximiya_9_key_ru.pdf',
        grade: 9,
        clusters: [5],
        clusterType: 'A',
        icon: '🧪',
        color: '0xFFFF6B6B',
        hasTest: false,
      ),
    ];
  }

  // ════════════════════════════════════════════════════════════════
  // 11 КЛАСС
  // ════════════════════════════════════════════════════════════════
  static List<Book> getGrade11Books() {
    return [
      // ────────────────────────────────────────────────────────────
      // ЗАБОНИ ТОҶИКӢ - Присутствует во ВСЕХ кластерах (AB)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_tojiki',
        nameTj: 'Забони тоҷикӣ',
        nameRu: 'Таджикский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_tojiki_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_tojiki_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_tojiki_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_tojiki_11_key_ru.pdf',
        grade: 11,
        clusters: [1, 2, 3, 4, 5],
        clusterType: 'AB',
        icon: '📚',
        color: '0xFF6C63FF',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // МАТЕМАТИКА - Кластер 1, 2 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_matematika',
        nameTj: 'Математика',
        nameRu: 'Математика',
        pdfPathTj: 'assets/books/tajik/matematika_11.pdf',
        pdfPathRu: 'assets/books/russian/matematika_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/matematika_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/matematika_11_key_ru.pdf',
        grade: 11,
        clusters: [1, 2],
        clusterType: 'A',
        icon: '📐',
        color: '0xFF4CAF50',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ХИМИЯ - Кластер 1, 5 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_ximiya',
        nameTj: 'Химия',
        nameRu: 'Химия',
        pdfPathTj: 'assets/books/tajik/ximiya_11.pdf',
        pdfPathRu: 'assets/books/russian/ximiya_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/ximiya_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/ximiya_11_key_ru.pdf',
        grade: 11,
        clusters: [1, 5],
        clusterType: 'A',
        icon: '🧪',
        color: '0xFFFF6B6B',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ФИЗИКА - Кластер 1, 5 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_fizika',
        nameTj: 'Физика',
        nameRu: 'Физика',
        pdfPathTj: 'assets/books/tajik/fizika_11.pdf',
        pdfPathRu: 'assets/books/russian/fizika_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/fizika_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/fizika_11_key_ru.pdf',
        grade: 11,
        clusters: [1, 5],
        clusterType: 'A',
        icon: '⚛️',
        color: '0xFF0984E3',
        hasTest: true,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ГЕОГРАФИЯ - Кластер 2 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_geografiya',
        nameTj: 'Ҷуғрофия',
        nameRu: 'География',
        pdfPathTj: 'assets/books/tajik/geografiya_11.pdf',
        pdfPathRu: 'assets/books/russian/geografiya_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/geografiya_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/geografiya_11_key_ru.pdf',
        grade: 11,
        clusters: [2],
        clusterType: 'B',
        icon: '🌍',
        color: '0xFF74B9FF',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ЯЗЫКИ НА ВЫБОР - Кластер 2, 3, 4 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      
      // Английский
      Book(
        id: '11_anglisi',
        nameTj: 'Забони англисӣ',
        nameRu: 'Английский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_anglisi_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_anglisi_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_anglisi_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_anglisi_11_key_ru.pdf',
        grade: 11,
        clusters: [2, 3, 4],
        clusterType: 'B',
        icon: '🇬🇧',
        color: '0xFF0984E3',
        hasTest: false,
      ),
      
      // Немецкий
      Book(
        id: '11_nemisi',
        nameTj: 'Забони немисӣ',
        nameRu: 'Немецкий язык',
        pdfPathTj: 'assets/books/tajik/zaboni_nemisi_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_nemisi_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_nemisi_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_nemisi_11_key_ru.pdf',
        grade: 11,
        clusters: [2, 3, 4],
        clusterType: 'B',
        icon: '🇩🇪',
        color: '0xFFFDCB6E',
        hasTest: false,
      ),
      
      // Французский
      Book(
        id: '11_fransuzi',
        nameTj: 'Забони франсузӣ',
        nameRu: 'Французский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_fransuzi_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_fransuzi_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_fransuzi_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_fransuzi_11_key_ru.pdf',
        grade: 11,
        clusters: [2, 3, 4],
        clusterType: 'B',
        icon: '🇫🇷',
        color: '0xFF00B894',
        hasTest: false,
      ),
      
      // Арабский
      Book(
        id: '11_arabi',
        nameTj: 'Забони арабӣ',
        nameRu: 'Арабский язык',
        pdfPathTj: 'assets/books/tajik/zaboni_arabi_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_arabi_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_arabi_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_arabi_11_key_ru.pdf',
        grade: 11,
        clusters: [2, 3, 4],
        clusterType: 'B',
        icon: '🕌',
        color: '0xFFD63031',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ТАЪРИХ - Кластер 3, 4 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_tarix',
        nameTj: 'Таърих',
        nameRu: 'История',
        pdfPathTj: 'assets/books/tajik/tarix_11.pdf',
        pdfPathRu: 'assets/books/russian/tarix_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/tarix_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/tarix_11_key_ru.pdf',
        grade: 11,
        clusters: [3, 4],
        clusterType: 'B',
        icon: '📜',
        color: '0xFF6C5CE7',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // АДАБИЁТИ ТОҶИК - Кластер 3 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_adabiyot',
        nameTj: 'Адабиёти тоҷик',
        nameRu: 'Таджикская литература',
        pdfPathTj: 'assets/books/tajik/adabiyoti_tojik_11.pdf',
        pdfPathRu: 'assets/books/russian/adabiyoti_tojik_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/adabiyoti_tojik_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/adabiyoti_tojik_11_key_ru.pdf',
        grade: 11,
        clusters: [3],
        clusterType: 'B',
        icon: '📖',
        color: '0xFFA29BFE',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ЗАБОН ВА АДАБИЁТИ РУС - Кластер 3 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_zaboni_adabiyoti_rus',
        nameTj: 'Забон ва адабиёти рус',
        nameRu: 'Русский язык и литература',
        pdfPathTj: 'assets/books/tajik/zaboni_adabiyoti_rus_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_adabiyoti_rus_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_adabiyoti_rus_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_adabiyoti_rus_11_key_ru.pdf',
        grade: 11,
        clusters: [3],
        clusterType: 'B',
        icon: '🇷🇺',
        color: '0xFFE17055',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ЗАБОН ВА АДАБИЁТИ ӮЗБЕК - Кластер 3 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_zaboni_adabiyoti_uzbek',
        nameTj: 'Забон ва адабиёти ӯзбек',
        nameRu: 'Узбекский язык и литература',
        pdfPathTj: 'assets/books/tajik/zaboni_adabiyoti_uzbek_11.pdf',
        pdfPathRu: 'assets/books/russian/zaboni_adabiyoti_uzbek_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/zaboni_adabiyoti_uzbek_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/zaboni_adabiyoti_uzbek_11_key_ru.pdf',
        grade: 11,
        clusters: [3],
        clusterType: 'B',
        icon: '🇺🇿',
        color: '0xFF55EFC4',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // ҲУҚУҚ (ПРАВО) - Кластер 4 (Кластер Б)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_xuquq',
        nameTj: 'Ҳуқуқ',
        nameRu: 'Право',
        pdfPathTj: 'assets/books/tajik/xuquq_11.pdf',
        pdfPathRu: 'assets/books/russian/xuquq_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/xuquq_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/xuquq_11_key_ru.pdf',
        grade: 11,
        clusters: [4],
        clusterType: 'B',
        icon: '⚖️',
        color: '0xFF2D3436',
        hasTest: false,
      ),
      
      // ────────────────────────────────────────────────────────────
      // БИОЛОГИЯ - Кластер 5 (Кластер А)
      // ────────────────────────────────────────────────────────────
      Book(
        id: '11_biologiya',
        nameTj: 'Биология',
        nameRu: 'Биология',
        pdfPathTj: 'assets/books/tajik/biologiya_11.pdf',
        pdfPathRu: 'assets/books/russian/biologiya_11_ru.pdf',
        pdfKeyPathTj: 'assets/books/tajik/biologiya_11_key.pdf',
        pdfKeyPathRu: 'assets/books/russian/biologiya_11_key_ru.pdf',
        grade: 11,
        clusters: [5],
        clusterType: 'A',
        icon: '🧬',
        color: '0xFF00B894',
        hasTest: false,
      ),
    ];
  }
  
  // ════════════════════════════════════════════════════════════════
  // ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ
  // ════════════════════════════════════════════════════════════════
  
  // Получить все книги
  static List<Book> getAllBooks() {
    return [...getGrade9Books(), ...getGrade11Books()];
  }
  
  // Получить книги по классу
  static List<Book> getBooksByGrade(int grade) {
    return grade == 9 ? getGrade9Books() : getGrade11Books();
  }
  
  // Получить книги по кластеру
  static List<Book> getBooksByCluster(int grade, int cluster) {
    final allBooks = getBooksByGrade(grade);
    return allBooks.where((book) => book.clusters.contains(cluster)).toList();
  }
  
  // Получить книги по типу кластера
  static List<Book> getBooksByClusterType(int grade, String clusterType) {
    final allBooks = getBooksByGrade(grade);
    return allBooks.where((book) => 
      book.clusterType == clusterType || book.clusterType == 'AB'
    ).toList();
  }
  
  // Получить книги с тестами
  static List<Book> getBooksWithTests(int grade) {
    final allBooks = getBooksByGrade(grade);
    return allBooks.where((book) => book.hasTest).toList();
  }
  
  // Получить книгу по ID
  static Book? getBookById(String id) {
    try {
      return getAllBooks().firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}