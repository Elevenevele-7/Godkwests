import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/sync_columns.dart';
import '../../finance/data/finance_state.dart';
import '../../knowledge/data/book_repository.dart';
import '../../progression/data/growth_state.dart';
import '../../progression/domain/evolution.dart';
import '../../visions/data/vision_repository.dart';

/// Thread id for the multi-advisor Council Chamber.
const chamberThread = 'chamber';

class CouncilMessage {
  const CouncilMessage({
    required this.id,
    required this.thread,
    required this.author,
    required this.body,
    required this.at,
  });

  final String id;
  final String thread;

  /// `user` or an advisor id.
  final String author;
  final String body;
  final DateTime at;

  bool get fromUser => author == 'user';
}

class CouncilUnavailable implements Exception {
  const CouncilUnavailable(this.message);
  final String message;

  @override
  String toString() => message;
}

enum TutorTask { explain, summarize, quiz }

/// Talks to the `council` Supabase function. Sends the user's progress and
/// budget *status* only, never amounts (agreed 2026-11-02).
class CouncilService {
  CouncilService(this._ref);

  final Ref _ref;

  AppDatabase get _db => _ref.read(databaseProvider);

  Stream<List<CouncilMessage>> watchThread(String thread) =>
      (_db.select(_db.councilMessages)
            ..where((m) => m.thread.equals(thread) & m.deleted.equals(false))
            ..orderBy([(m) => OrderingTerm.asc(m.updatedAt)]))
          .watch()
          .map(
            (rows) => [
              for (final r in rows)
                CouncilMessage(
                  id: r.id,
                  thread: r.thread,
                  author: r.author,
                  body: r.body,
                  at: r.updatedAt,
                ),
            ],
          );

  Future<void> _store(String thread, String author, String body) => _db
      .into(_db.councilMessages)
      .insert(
        CouncilMessagesCompanion.insert(
          id: newId(),
          updatedAt: DateTime.now(),
          thread: thread,
          author: author,
          body: body,
        ),
      );

  void _checkAvailable() {
    if (!Env.hasSupabase) {
      throw const CouncilUnavailable(
        'The AI Council needs the app to be connected to its server.',
      );
    }
    if (Supabase.instance.client.auth.currentUser == null) {
      throw const CouncilUnavailable(
        'Sign in (Profile → Account & sync) to talk to the Council.',
      );
    }
  }

  /// Sends [message] to [advisors] in [thread] and stores the replies.
  Future<void> ask({
    required String thread,
    required List<String> advisors,
    required String message,
  }) async {
    _checkAvailable();
    final history = (await watchThread(
      thread,
    ).first).reversed.take(20).toList().reversed.toList();
    await _store(thread, 'user', message);
    final profile = _ref.read(growthStateProvider).value?.profile;
    final data = await _invoke({
      'mode': 'council',
      'advisors': advisors,
      'strictness': profile?.strictness ?? 2,
      'message': message,
      'context': buildContext(),
      'history': [
        for (final m in history)
          {
            'role': m.fromUser ? 'user' : 'assistant',
            'content': m.fromUser ? m.body : '[${m.author}] ${m.body}',
          },
      ],
    });
    for (final r in (data['replies'] as List).cast<Map<String, dynamic>>()) {
      await _store(thread, r['advisor'] as String, r['text'] as String);
    }
  }

  /// Explains, summarises or quizzes on a passage the user is reading.
  Future<String> tutor(TutorTask task, String passage) async {
    _checkAvailable();
    final data = await _invoke({
      'mode': 'tutor',
      'task': task.name,
      'message': passage,
    });
    return ((data['replies'] as List).first as Map)['text'] as String;
  }

  Future<Map<String, dynamic>> _invoke(Map<String, dynamic> body) async {
    try {
      final res = await Supabase.instance.client.functions.invoke(
        'council',
        body: body,
      );
      return res.data as Map<String, dynamic>;
    } on FunctionException catch (e) {
      final details = e.details;
      throw CouncilUnavailable(
        details is Map && details['error'] is String
            ? details['error'] as String
            : 'The Council couldn\'t answer right now.',
      );
    }
  }

  /// A plain-language summary of the user's progress for the advisors.
  String buildContext() {
    final s = _ref.read(growthStateProvider).value;
    if (s == null) return '';
    final finance = _ref.read(financeStateProvider).value;
    final visions = _ref.read(visionsProvider).value ?? [];
    final book = _ref.read(currentBookProvider).value;
    final lines = <String>[
      if (s.profile.displayName.isNotEmpty) 'Name: ${s.profile.displayName}',
      'Level ${s.level.level}, ${s.totals.xp} XP, ${s.totals.dp} DP, '
          '${s.totals.vp} VP',
      'Momentum ${s.momentum}/100, Discipline Score ${s.discipline}/100',
      'Accountability mode: ${s.profile.mode.label}',
      'Today: ${s.missionsDone} of ${s.missions.length} missions done',
      for (final m in s.missions)
        '- ${m.habit.name}: ${m.done ? 'done' : 'not yet'}, streak '
            '${m.streak}${m.inRecovery ? ', recovery challenge active' : ''}'
            '${m.advice == EvolutionAdvice.offerEvolve ? ', ready to evolve' : ''}',
      if (s.identity.isNotEmpty)
        'Growth areas: ${s.identity.entries.map((e) => '${e.key} ${e.value ?? '-'}%').join(', ')}',
      for (final v in visions.where((v) => !v.isCompleted))
        'Vision "${v.title}": ${(v.progress * 100).round()}% done, due '
            '${v.deadline.toIso8601String().substring(0, 10)}',
      if (finance != null)
        'Budget this week: ${finance.snapshot.status.label}; savings '
            'target ${finance.savedTodayTarget ? 'met' : 'not met'} today',
      if (book != null)
        'Reading "${book.title}", ${(book.progress * 100).round()}% done',
    ];
    return lines.join('\n');
  }
}

final councilServiceProvider = Provider(CouncilService.new);

final councilThreadProvider =
    StreamProvider.family<List<CouncilMessage>, String>(
      (ref, thread) => ref.watch(councilServiceProvider).watchThread(thread),
    );
