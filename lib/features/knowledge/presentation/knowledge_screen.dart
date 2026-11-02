import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/widgets/async_body.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/section_card.dart';
import '../../visions/data/vision_repository.dart';
import '../data/book_repository.dart';
import '../domain/book.dart';

class KnowledgeScreen extends ConsumerWidget {
  const KnowledgeScreen({super.key});

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    try {
      final book = await ref.read(bookRepositoryProvider).importFromDevice();
      if (book != null && context.mounted) {
        context.push(Routes.reader(book.id));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Import failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Knowledge')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _import(context, ref),
        icon: const Icon(Icons.upload_file),
        label: const Text('Import PDF / EPUB'),
      ),
      body: AsyncBody(
        value: ref.watch(booksProvider),
        data: (books) {
          final reading = books.where((b) => !b.isFinished).toList();
          final finished = books.where((b) => b.isFinished).toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              SectionCard(
                title: 'Library',
                child: reading.isEmpty
                    ? const EmptyState(
                        'Import a PDF or EPUB from your phone. Your reading '
                        'progress, bookmarks, highlights and notes are saved '
                        'as you go.',
                      )
                    : Column(
                        children: [for (final b in reading) _BookTile(book: b)],
                      ),
              ),
              if (finished.isNotEmpty) ...[
                const SizedBox(height: 12),
                SectionCard(
                  title: 'Finished',
                  child: Column(
                    children: [for (final b in finished) _BookTile(book: b)],
                  ),
                ),
              ],
              const SizedBox(height: 12),
              const SectionCard(
                title: 'Learning paths',
                child: _LearningPaths(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BookTile extends ConsumerWidget {
  const _BookTile({required this.book});

  final Book book;

  Future<void> _linkVision(BuildContext context, WidgetRef ref) async {
    final visions = (ref.read(visionsProvider).value ?? [])
        .where((v) => !v.isCompleted)
        .toList();
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Counts toward vision'),
        children: [
          if (visions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Create a vision like "Read 24 books" (unit: books) first.',
              ),
            ),
          for (final v in visions)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, v.id),
              child: Text(v.title),
            ),
        ],
      ),
    );
    if (picked != null) {
      await ref
          .read(bookRepositoryProvider)
          .save(book.copyWith(visionId: picked));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitle = [
      if (book.author != null) book.author!,
      book.format.name.toUpperCase(),
      book.isFinished
          ? 'Finished ${shortDate(book.finishedOn!)}'
          : '${(book.progress * 100).round()}% read',
    ].join(' · ');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        book.format == BookFormat.pdf
            ? Icons.picture_as_pdf_outlined
            : Icons.menu_book_outlined,
      ),
      title: Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle),
      onTap: () => context.push(Routes.reader(book.id)),
      trailing: PopupMenuButton<String>(
        onSelected: (v) async {
          if (v == 'vision') await _linkVision(context, ref);
          if (v == 'delete') {
            await ref.read(bookRepositoryProvider).delete(book);
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'vision', child: Text('Count toward a vision')),
          PopupMenuItem(value: 'delete', child: Text('Remove from library')),
        ],
      ),
    );
  }
}

/// Starter learning paths: topics with practical first steps. Each step can
/// become a habit; the AI Council can turn a book into a fuller plan.
class _LearningPaths extends StatelessWidget {
  const _LearningPaths();

  static const paths = {
    'Psychology': [
      'Learn the habit loop: cue, routine, reward',
      'Notice and name one emotion a day',
      'Read about cognitive biases, one per week',
    ],
    'Philosophy': [
      'Read one Stoic passage each morning',
      'Journal: what is in my control today?',
      'Compare two ethical views on a decision you face',
    ],
    'Trading & investing': [
      'Learn compound interest with your own numbers',
      'Understand risk vs. return before any investment',
      'Paper-trade for a month before using real money',
    ],
    'Negotiation': [
      'Know your walk-away point before any negotiation',
      'Practise asking open questions in conversations',
      'Review one negotiation a week: what worked?',
    ],
    'Critical thinking': [
      'For one claim a day, ask: what\'s the evidence?',
      'Steel-man an opinion you disagree with',
      'Spot one logical fallacy in the news each week',
    ],
  };

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final e in paths.entries)
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(e.key),
          children: [
            for (final step in e.value)
              ListTile(
                dense: true,
                leading: const Icon(Icons.arrow_right),
                title: Text(step),
              ),
          ],
        ),
    ],
  );
}
