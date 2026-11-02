import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

import '../../../core/clock.dart';
import '../../../core/database/sync_columns.dart';
import '../../../core/time/day.dart';
import '../../visions/data/vision_repository.dart';
import '../data/book_repository.dart';
import '../domain/book.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, required this.bookId});

  final String bookId;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  Book? _book;
  PdfController? _pdf;
  List<epub.EpubChapter>? _chapters;
  int _position = 0;
  String? _error;

  BookRepository get _repo => ref.read(bookRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _open();
  }

  Future<void> _open() async {
    final book = await _repo.book(widget.bookId);
    if (book == null) return;
    final path = book.localPath;
    if (path == null || !File(path).existsSync()) {
      setState(() {
        _book = book;
        _error =
            'This book\'s file isn\'t on this device. Import it again here '
            'to read it.';
      });
      return;
    }
    final opened = book.copyWith(lastOpenedAt: DateTime.now());
    await _repo.save(opened);
    if (book.format == BookFormat.pdf) {
      _pdf = PdfController(
        document: PdfDocument.openFile(path),
        initialPage: book.position < 1 ? 1 : book.position,
      );
      _position = book.position < 1 ? 1 : book.position;
    } else {
      try {
        final parsed = await epub.EpubReader.readBook(File(path).readAsBytes());
        _chapters = flattenChapters(parsed.Chapters ?? const []);
        _position = book.position.clamp(
          0,
          (_chapters!.length - 1).clamp(0, 1 << 30),
        );
      } catch (e) {
        _error = 'Couldn\'t open this EPUB: $e';
      }
    }
    if (mounted) setState(() => _book = opened);
  }

  @override
  void dispose() {
    _pdf?.dispose();
    super.dispose();
  }

  int get _total => _book?.format == BookFormat.epub
      ? (_chapters?.length ?? 0)
      : (_book?.totalPages ?? _pdf?.pagesCount ?? 0);

  Future<void> _moveTo(int position) async {
    final book = _book;
    if (book == null) return;
    final total = _total;
    final progress = total == 0
        ? 0.0
        : book.format == BookFormat.pdf
        ? position / total
        : (position + 1) / total;
    final updated = book.copyWith(
      position: position,
      progress: progress.clamp(0, 1).toDouble(),
      totalPages: total == 0 ? null : total,
    );
    setState(() {
      _position = position;
      _book = updated;
    });
    await _repo.save(updated);
  }

  Future<void> _annotate(AnnotationKind kind, {String? quote}) async {
    String? note;
    if (kind != AnnotationKind.bookmark) {
      final controller = TextEditingController();
      note = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(kind == AnnotationKind.highlight ? 'Highlight' : 'Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (quote != null)
                Text('"$quote"', style: Theme.of(context).textTheme.bodySmall),
              TextField(
                controller: controller,
                autofocus: true,
                maxLines: 4,
                minLines: 1,
                decoration: const InputDecoration(labelText: 'Your note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      controller.dispose();
      if (note == null) return;
    }
    await _repo.addAnnotation(
      Annotation(
        id: newId(),
        bookId: widget.bookId,
        kind: kind,
        position: _position,
        quote: quote,
        note: note?.trim().isEmpty ?? true ? null : note!.trim(),
      ),
    );
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${kind.name} saved')));
    }
  }

  Future<void> _finish() async {
    final book = _book!;
    final today = ref.read(clockProvider)().dateOnly;
    await _repo.save(book.copyWith(finishedOn: today, progress: 1));
    // A book counts toward a linked "books" vision.
    final vision = (ref.read(visionsProvider).value ?? [])
        .where((v) => v.id == book.visionId && !v.isCompleted)
        .firstOrNull;
    if (vision != null) {
      await ref
          .read(visionRepositoryProvider)
          .save(vision.copyWith(currentValue: vision.currentValue + 1));
    }
    if (mounted) Navigator.pop(context);
  }

  void _showAnnotations() => showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final items = ref.watch(annotationsProvider(widget.bookId)).value ?? [];
        final unit = _book?.format == BookFormat.pdf ? 'Page' : 'Chapter';
        if (items.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Text('No bookmarks, highlights or notes yet.'),
          );
        }
        return ListView(
          children: [
            for (final a in items)
              ListTile(
                leading: Icon(switch (a.kind) {
                  AnnotationKind.bookmark => Icons.bookmark_outline,
                  AnnotationKind.highlight => Icons.format_quote,
                  AnnotationKind.note => Icons.sticky_note_2_outlined,
                }),
                title: Text(
                  a.quote ?? a.note ?? '$unit ${_displayPosition(a.position)}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  [
                    '$unit ${_displayPosition(a.position)}',
                    if (a.quote != null && a.note != null) a.note!,
                  ].join(' · '),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _jump(a.position);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () =>
                      ref.read(bookRepositoryProvider).deleteAnnotation(a.id),
                ),
              ),
          ],
        );
      },
    ),
  );

  int _displayPosition(int p) => _book?.format == BookFormat.pdf ? p : p + 1;

  void _jump(int position) {
    if (_book?.format == BookFormat.pdf) {
      _pdf?.jumpToPage(position);
    } else {
      _moveTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = _book;
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? '', overflow: TextOverflow.ellipsis),
        actions: [
          if (book != null && _error == null) ...[
            IconButton(
              tooltip: 'Bookmark',
              icon: const Icon(Icons.bookmark_add_outlined),
              onPressed: () => _annotate(AnnotationKind.bookmark),
            ),
            IconButton(
              tooltip: 'Add note',
              icon: const Icon(Icons.note_add_outlined),
              onPressed: () => _annotate(AnnotationKind.note),
            ),
            IconButton(
              tooltip: 'Bookmarks & notes',
              icon: const Icon(Icons.list_alt),
              onPressed: _showAnnotations,
            ),
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'finish') _finish();
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'finish', child: Text('Mark as finished')),
              ],
            ),
          ],
        ],
      ),
      body: _error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(_error!),
              ),
            )
          : book == null
          ? const Center(child: CircularProgressIndicator())
          : book.format == BookFormat.pdf
          ? _buildPdf()
          : _buildEpub(),
    );
  }

  Widget _buildPdf() => Column(
    children: [
      Expanded(
        child: PdfView(
          controller: _pdf!,
          scrollDirection: Axis.vertical,
          onDocumentLoaded: (doc) {
            if (_book?.totalPages != doc.pagesCount) {
              _repo.save(_book!.copyWith(totalPages: doc.pagesCount));
              setState(
                () => _book = _book!.copyWith(totalPages: doc.pagesCount),
              );
            }
          },
          onPageChanged: _moveTo,
        ),
      ),
      _ProgressFooter(
        label: 'Page $_position of $_total',
        progress: _book!.progress,
      ),
    ],
  );

  Widget _buildEpub() {
    final chapters = _chapters ?? const [];
    if (chapters.isEmpty) {
      return const Center(child: Text('This EPUB has no readable chapters.'));
    }
    final chapter = chapters[_position];
    final text = htmlToText(chapter.HtmlContent ?? '');
    return Column(
      children: [
        Expanded(
          child: SelectionArea(
            contextMenuBuilder: (context, state) {
              final selected = _selection;
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: state.contextMenuAnchors,
                buttonItems: [
                  ...state.contextMenuButtonItems,
                  if (selected != null && selected.trim().isNotEmpty)
                    ContextMenuButtonItem(
                      label: 'Highlight',
                      onPressed: () {
                        state.hideToolbar();
                        _annotate(
                          AnnotationKind.highlight,
                          quote: selected.trim(),
                        );
                      },
                    ),
                ],
              );
            },
            onSelectionChanged: (s) => _selection = s?.plainText,
            child: ListView(
              key: PageStorageKey(_position),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                if (chapter.Title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      chapter.Title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(height: 1.6),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              tooltip: 'Previous chapter',
              onPressed: _position > 0 ? () => _moveTo(_position - 1) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: _ProgressFooter(
                label: 'Chapter ${_position + 1} of ${chapters.length}',
                progress: _book!.progress,
              ),
            ),
            IconButton(
              tooltip: 'Next chapter',
              onPressed: _position < chapters.length - 1
                  ? () => _moveTo(_position + 1)
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }

  String? _selection;
}

class _ProgressFooter extends StatelessWidget {
  const _ProgressFooter({required this.label, required this.progress});

  final String label;
  final double progress;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    ),
  );
}

/// Plain text from chapter HTML: keeps paragraph breaks, drops tags.
String htmlToText(String html) {
  var s = html
      .replaceAll(RegExp(r'<(script|style)[^>]*>.*?</\1>', dotAll: true), '')
      .replaceAll(RegExp(r'<head[^>]*>.*?</head>', dotAll: true), '')
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(
        RegExp(r'</(p|div|h[1-6]|li|blockquote)>', caseSensitive: false),
        '\n\n',
      )
      .replaceAll(RegExp(r'<[^>]+>'), '');
  const entities = {
    '&nbsp;': ' ',
    '&amp;': '&',
    '&lt;': '<',
    '&gt;': '>',
    '&quot;': '"',
    '&#39;': "'",
    '&apos;': "'",
    '&mdash;': '—',
    '&ndash;': '–',
    '&hellip;': '…',
    '&rsquo;': '’',
    '&lsquo;': '‘',
    '&rdquo;': '”',
    '&ldquo;': '“',
  };
  entities.forEach((k, v) => s = s.replaceAll(k, v));
  s = s.replaceAllMapped(
    RegExp(r'&#(\d+);'),
    (m) => String.fromCharCode(int.parse(m[1]!)),
  );
  return s
      .split('\n')
      .map((l) => l.trim())
      .join('\n')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}
