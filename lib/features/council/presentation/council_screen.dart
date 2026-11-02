import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/data/profile_repository.dart';
import '../data/council_service.dart';
import '../domain/advisor.dart';

class CouncilScreen extends ConsumerWidget {
  const CouncilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coach = ref.watch(profileProvider).value?.advisor;
    return Scaffold(
      appBar: AppBar(title: const Text('AI Council')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile(
              leading: const Icon(Icons.groups_outlined),
              title: const Text('Council Chamber'),
              subtitle: const Text(
                'Bring a decision to several advisors and hear each '
                'perspective.',
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ChamberSetupScreen()),
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final a in Advisor.values)
            ListTile(
              leading: CircleAvatar(child: Text(a.title.split(' ').last[0])),
              title: Text(a.title + (a == coach ? ' · your coach' : '')),
              subtitle: Text(a.focus),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CouncilChatScreen(
                    thread: a.name,
                    advisors: [a],
                    title: a.title,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            'Advisors give advice only. Points, penalties and budgets are '
            'always decided by the app\'s own rules. They see your progress '
            'and budget status, never your amounts.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class ChamberSetupScreen extends StatefulWidget {
  const ChamberSetupScreen({super.key});

  @override
  State<ChamberSetupScreen> createState() => _ChamberSetupScreenState();
}

class _ChamberSetupScreenState extends State<ChamberSetupScreen> {
  final _chosen = <Advisor>{
    Advisor.strategist,
    Advisor.financialMentor,
    Advisor.philosopher,
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Choose up to 4 advisors')),
    body: ListView(
      children: [
        for (final a in Advisor.values)
          CheckboxListTile(
            value: _chosen.contains(a),
            title: Text(a.title),
            subtitle: Text(a.focus),
            onChanged: (on) => setState(() {
              if (on! && _chosen.length < 4) _chosen.add(a);
              if (!on) _chosen.remove(a);
            }),
          ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton(
          onPressed: _chosen.isEmpty
              ? null
              : () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => CouncilChatScreen(
                      thread: chamberThread,
                      advisors: _chosen.toList(),
                      title: 'Council Chamber',
                    ),
                  ),
                ),
          child: const Text('Enter the Chamber'),
        ),
      ),
    ),
  );
}

class CouncilChatScreen extends ConsumerStatefulWidget {
  const CouncilChatScreen({
    super.key,
    required this.thread,
    required this.advisors,
    required this.title,
  });

  final String thread;
  final List<Advisor> advisors;
  final String title;

  @override
  ConsumerState<CouncilChatScreen> createState() => _CouncilChatScreenState();
}

class _CouncilChatScreenState extends ConsumerState<CouncilChatScreen> {
  final _input = TextEditingController();
  var _sending = false;
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    _input.clear();
    try {
      await ref
          .read(councilServiceProvider)
          .ask(
            thread: widget.thread,
            advisors: [for (final a in widget.advisors) a.name],
            message: text,
          );
    } on CouncilUnavailable catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = 'Couldn\'t reach the Council: $e');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final messages =
        ref.watch(councilThreadProvider(widget.thread)).value ?? [];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        widget.advisors.length > 1
                            ? 'Describe a decision you\'re facing. Each '
                                  'advisor will give their perspective.'
                            : widget.advisors.single.focus,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final m = messages[messages.length - 1 - i];
                      final advisor = Advisor.values
                          .where((a) => a.name == m.author)
                          .firstOrNull;
                      return Align(
                        alignment: m.fromUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: m.fromUser
                                ? theme.colorScheme.primaryContainer
                                : theme.colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (advisor != null)
                                Text(
                                  advisor.title,
                                  style: theme.textTheme.labelMedium,
                                ),
                              SelectableText(m.body),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_sending) const LinearProgressIndicator(),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _error!,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Ask the Council…',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
