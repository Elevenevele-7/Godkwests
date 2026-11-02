enum BookFormat { pdf, epub }

enum AnnotationKind { bookmark, highlight, note }

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.format,
    this.author,
    this.localPath,
    this.totalPages,
    this.position = 0,
    this.progress = 0,
    this.visionId,
    this.lastOpenedAt,
    this.finishedOn,
  });

  final String id;
  final String title;
  final String? author;
  final BookFormat format;

  /// The imported copy on this device; null on devices it was synced to
  /// but not imported on.
  final String? localPath;

  /// Pages (PDF) or chapters (EPUB).
  final int? totalPages;

  /// 1-based page (PDF) or 0-based chapter (EPUB).
  final int position;

  /// 0–1.
  final double progress;
  final String? visionId;
  final DateTime? lastOpenedAt;
  final DateTime? finishedOn;

  bool get isFinished => finishedOn != null;

  Book copyWith({
    String? title,
    String? author,
    String? localPath,
    int? totalPages,
    int? position,
    double? progress,
    String? visionId,
    DateTime? lastOpenedAt,
    DateTime? finishedOn,
  }) => Book(
    id: id,
    title: title ?? this.title,
    author: author ?? this.author,
    format: format,
    localPath: localPath ?? this.localPath,
    totalPages: totalPages ?? this.totalPages,
    position: position ?? this.position,
    progress: progress ?? this.progress,
    visionId: visionId ?? this.visionId,
    lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
    finishedOn: finishedOn ?? this.finishedOn,
  );
}

class Annotation {
  const Annotation({
    required this.id,
    required this.bookId,
    required this.kind,
    required this.position,
    this.quote,
    this.note,
    this.createdAt,
  });

  final String id;
  final String bookId;
  final AnnotationKind kind;

  /// Page (PDF) or chapter (EPUB).
  final int position;
  final String? quote;
  final String? note;
  final DateTime? createdAt;
}
