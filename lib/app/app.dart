import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/clock.dart';
import '../features/progression/data/growth_service.dart';
import '../features/sync/data/supabase_sync.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class GodkwestsApp extends ConsumerStatefulWidget {
  const GodkwestsApp({super.key});

  @override
  ConsumerState<GodkwestsApp> createState() => _GodkwestsAppState();
}

class _GodkwestsAppState extends ConsumerState<GodkwestsApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // A new day may have started while the app was in the background.
      ref.invalidate(clockProvider);
      _refresh();
    }
  }

  /// Applies anything owed for past days, then syncs if signed in.
  Future<void> _refresh() async {
    await ref.read(growthServiceProvider).closePastDays();
    await ref.read(syncControllerProvider.notifier).syncNow();
    // Sync may have brought rows from another device.
    await ref.read(growthServiceProvider).closePastDays();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Godkwests',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
