import 'dart:io';

import 'package:drift/drift.dart';
import 'package:epubx/epubx.dart' as epub;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/sync_columns.dart';
import '../domain/book.dart';

class BookRepository {
  BookRepository(this._db);

  final AppDatabase _db;

  Stream<List<Book>> watchBooks() =>
      (_db.select(_db.books)
            ..where((b) => b.deleted.equals(false))
            ..orderBy([
              (b) => OrderingTerm(
                expression: b.lastOpenedAt,
                mode: OrderingMode.desc,
                nulls: NullsOrder.last,
              ),
            ]))
          .watch()
          .map((rows) => rows.map(_book).toList());

  Future<Book?> book(String id) async {
    final r = await (_db.select(
      _db.books,
    )..where((b) => b.id.equals(id))).getSingleOrNull();
    return r == null ? null : _book(r);
  }

  Book _book(BookRow r) => Book(
    id: r.id,
    title: r.title,
    author: r.author,
    format: BookFormat.values.byName(r.format),
    localPath: r.localPath,
    totalPages: r.totalPages,
    position: r.position,
    progress: r.progress,
    visionId: r.visionId,
    lastOpenedAt: r.lastOpenedAt,
    finishedOn: r.finishedOn,
  );

  Future<void> save(Book b) => _db
      .into(_db.books)
      .insertOnConflictUpdate(
        BooksCompanion.insert(
          id: b.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          title: b.title,
          author: Value(b.author),
          format: b.format.name,
          localPath: Value(b.localPath),
          totalPages: Value(b.totalPages),
          position: Value(b.position),
          progress: Value(b.progress),
          visionId: Value(b.visionId),
          lastOpenedAt: Value(b.lastOpenedAt),
          finishedOn: Value(b.finishedOn),
        ),
      );

  Future<void> delete(Book b) async {
    await (_db.update(_db.books)..where((r) => r.id.equals(b.id))).write(
      BooksCompanion(
        deleted: const Value(true),
        dirty: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
    if (b.localPath != null) {
      final f = File(b.localPath!);
      if (await f.exists()) await f.delete();
    }
  }

  /// Lets the user pick a PDF or EPUB from the device and copies it into
  /// the app's private storage. Returns null if cancelled.
  Future<Book?> importFromDevice() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'epub'],
    );
    if (picked.isEmpty) return null;
    final file = picked.first;
    final ext = file.extension?.toLowerCase();
    final format = ext == 'epub' ? BookFormat.epub : BookFormat.pdf;
    final bytes = await file.readAsBytes();

    final id = newId();
    final dir = Directory(
      '${(await getApplicationDocumentsDirectory()).path}/books',
    );
    await dir.create(recursive: true);
    final path = '${dir.path}/$id.${format.name}';
    await File(path).writeAsBytes(bytes, flush: true);

    var title = file.name.replaceAll(
      RegExp(r'\.(pdf|epub)$', caseSensitive: false),
      '',
    );
    String? author;
    int? total;
    if (format == BookFormat.epub) {
      final book = await epub.EpubReader.readBook(bytes);
      title = book.Title?.trim().isNotEmpty == true ? book.Title! : title;
      author = book.Author;
      total = flattenChapters(book.Chapters ?? const []).length;
    }

    final book = Book(
      id: id,
      title: title,
      author: author,
      format: format,
      localPath: path,
      totalPages: total,
      position: format == BookFormat.pdf ? 1 : 0,
    );
    await save(book);
    return book;
  }

  // Annotations

  Stream<List<Annotation>> watchAnnotations(String bookId) =>
      (_db.select(_db.annotations)
            ..where((a) => a.bookId.equals(bookId) & a.deleted.equals(false))
            ..orderBy([(a) => OrderingTerm.asc(a.position)]))
          .watch()
          .map(
            (rows) => [
              for (final r in rows)
                Annotation(
                  id: r.id,
                  bookId: r.bookId,
                  kind: AnnotationKind.values.byName(r.kind),
                  position: r.position,
                  quote: r.quote,
                  note: r.note,
                  createdAt: r.updatedAt,
                ),
            ],
          );

  Future<void> addAnnotation(Annotation a) => _db
      .into(_db.annotations)
      .insertOnConflictUpdate(
        AnnotationsCompanion.insert(
          id: a.id,
          updatedAt: DateTime.now(),
          dirty: const Value(true),
          bookId: a.bookId,
          kind: a.kind.name,
          position: a.position,
          quote: Value(a.quote),
          note: Value(a.note),
        ),
      );

  Future<void> deleteAnnotation(String id) =>
      (_db.update(_db.annotations)..where((a) => a.id.equals(id))).write(
        AnnotationsCompanion(
          deleted: const Value(true),
          dirty: const Value(true),
          updatedAt: Value(DateTime.now()),
        ),
      );
}

/// Chapters and sub-chapters in reading order.
List<epub.EpubChapter> flattenChapters(List<epub.EpubChapter> chapters) => [
  for (final c in chapters) ...[c, ...flattenChapters(c.SubChapters ?? [])],
];

final bookRepositoryProvider = Provider(
  (ref) => BookRepository(ref.watch(databaseProvider)),
);

final booksProvider = StreamProvider<List<Book>>(
  (ref) => ref.watch(bookRepositoryProvider).watchBooks(),
);

/// The book to resume: most recently opened and not finished.
final currentBookProvider = Provider<AsyncValue<Book?>>(
  (ref) => ref
      .watch(booksProvider)
      .whenData(
        (books) => books
            .where((b) => b.lastOpenedAt != null && !b.isFinished)
            .firstOrNull,
      ),
);

final annotationsProvider = StreamProvider.family<List<Annotation>, String>(
  (ref, bookId) => ref.watch(bookRepositoryProvider).watchAnnotations(bookId),
);
