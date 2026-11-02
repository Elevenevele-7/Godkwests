import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../../../core/widgets/section_card.dart';
import '../data/supabase_sync.dart';

/// Account, sync and finance-encryption controls on the Profile tab.
class AccountCard extends ConsumerWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!Env.hasSupabase) {
      return const SectionCard(
        title: 'Account & sync',
        child: Text(
          'Everything is saved on this phone. Accounts, syncing between '
          'devices and the AI Council switch on once the app is connected '
          'to a Supabase project (see docs/setup.md).',
        ),
      );
    }
    final user = ref.watch(authUserProvider).value;
    return SectionCard(
      title: 'Account & sync',
      child: user == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign in to back up your progress, use it on several '
                  'devices and talk to the AI Council. Your data on this '
                  'phone is kept and uploaded after you sign in.',
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
                  child: const Text('Sign in or create account'),
                ),
              ],
            )
          : _SignedIn(user: user),
    );
  }
}

class _SignedIn extends ConsumerStatefulWidget {
  const _SignedIn({required this.user});

  final User user;

  @override
  ConsumerState<_SignedIn> createState() => _SignedInState();
}

class _SignedInState extends ConsumerState<_SignedIn> {
  FinanceKeyStatus? _keyStatus;

  @override
  void initState() {
    super.initState();
    _refreshKey();
  }

  Future<void> _refreshKey() async {
    try {
      final s = await ref.read(financeKeyServiceProvider).status();
      if (mounted) setState(() => _keyStatus = s);
    } catch (_) {
      // Offline: try again next time the screen opens.
    }
  }

  Future<void> _setUpKey() async {
    final passphrase = await _askSecret(
      context,
      title: 'Create a finance passphrase',
      body:
          'Your budget and spending are encrypted with this before they '
          'leave the phone. Nobody else, including the app\'s developer, can '
          'read them. Use at least 10 characters.',
      confirm: true,
    );
    if (passphrase == null) return;
    final recovery = await ref
        .read(financeKeyServiceProvider)
        .setUp(passphrase);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Save your recovery key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'If you forget your passphrase, this key is the only way to '
              'unlock your finance history on a new device. Write it down '
              'and keep it somewhere safe. It won\'t be shown again.',
            ),
            const SizedBox(height: 16),
            SelectableText(
              recovery,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontFamily: 'monospace'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Clipboard.setData(ClipboardData(text: recovery)),
            child: const Text('Copy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('I\'ve saved it'),
          ),
        ],
      ),
    );
    await _refreshKey();
    await ref.read(syncControllerProvider.notifier).syncNow();
  }

  Future<void> _unlock() async {
    final secret = await _askSecret(
      context,
      title: 'Unlock finance on this device',
      body: 'Enter your finance passphrase or your recovery key.',
    );
    if (secret == null) return;
    final ok = await ref.read(financeKeyServiceProvider).unlock(secret);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Finance unlocked' : 'That passphrase or key didn\'t match',
        ),
      ),
    );
    if (ok) {
      await _refreshKey();
      await ref.read(syncControllerProvider.notifier).syncNow();
    }
  }

  Future<void> _signOut() async {
    await ref.read(syncControllerProvider.notifier).syncNow();
    await ref.read(financeKeyServiceProvider).forgetLocal();
    await Supabase.instance.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final sync = ref.watch(syncControllerProvider);
    final theme = Theme.of(context);
    final status = sync.running
        ? 'Syncing…'
        : sync.error != null
        ? 'Last sync failed. Will retry. (${sync.error})'
        : sync.last != null
        ? 'Synced at ${TimeOfDay.fromDateTime(sync.last!).format(context)}'
        : 'Not synced yet this session';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Signed in as ${widget.user.email ?? 'you'}'),
        const SizedBox(height: 4),
        Text(status, style: theme.textTheme.bodySmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: sync.running
                  ? null
                  : () => ref.read(syncControllerProvider.notifier).syncNow(),
              icon: const Icon(Icons.sync),
              label: const Text('Sync now'),
            ),
            TextButton(onPressed: _signOut, child: const Text('Sign out')),
          ],
        ),
        const Divider(height: 24),
        Text('Finance encryption', style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        switch (_keyStatus) {
          null => const Text('Checking…'),
          FinanceKeyStatus.unlocked => const Text(
            'On. Finance records sync encrypted; only your devices can '
            'read them.',
          ),
          FinanceKeyStatus.notSetUp => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Finance records stay on this phone until you create a '
                'finance passphrase.',
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _setUpKey,
                child: const Text('Create passphrase'),
              ),
            ],
          ),
          FinanceKeyStatus.locked => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your finance history is encrypted. Unlock it on this '
                'device to sync it.',
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _unlock,
                child: const Text('Unlock finance'),
              ),
            ],
          ),
        },
      ],
    );
  }
}

Future<String?> _askSecret(
  BuildContext context, {
  required String title,
  required String body,
  bool confirm = false,
}) async {
  final a = TextEditingController();
  final b = TextEditingController();
  final form = GlobalKey<FormState>();
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(body),
            TextFormField(
              controller: a,
              obscureText: true,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Passphrase'),
              validator: (v) => confirm && (v ?? '').trim().length < 10
                  ? 'At least 10 characters'
                  : (v ?? '').trim().isEmpty
                  ? 'Required'
                  : null,
            ),
            if (confirm)
              TextFormField(
                controller: b,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Repeat'),
                validator: (v) => v != a.text ? 'Doesn\'t match' : null,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (form.currentState!.validate()) Navigator.pop(context, a.text);
          },
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  a.dispose();
  b.dispose();
  return result;
}

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  var _creating = false;
  var _busy = false;
  String? _message;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    final auth = Supabase.instance.client.auth;
    try {
      if (_creating) {
        final res = await auth.signUp(
          email: _email.text.trim(),
          password: _password.text,
        );
        if (res.session == null) {
          setState(
            () => _message =
                'Check your email to confirm your account, then sign in.',
          );
          return;
        }
      } else {
        await auth.signInWithPassword(
          email: _email.text.trim(),
          password: _password.text,
        );
      }
      await ref.read(syncControllerProvider.notifier).syncNow();
      if (mounted) Navigator.pop(context);
    } on AuthException catch (e) {
      setState(() => _message = e.message);
    } catch (e) {
      setState(() => _message = 'Couldn\'t reach the server: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(_creating ? 'Create account' : 'Sign in')),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (v) =>
                (v ?? '').contains('@') ? null : 'Enter your email',
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _password,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (v) =>
                (v ?? '').length < 8 ? 'At least 8 characters' : null,
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: Text(_creating ? 'Create account' : 'Sign in'),
          ),
          TextButton(
            onPressed: () => setState(() => _creating = !_creating),
            child: Text(
              _creating
                  ? 'I already have an account'
                  : 'New here? Create an account',
            ),
          ),
        ],
      ),
    ),
  );
}
