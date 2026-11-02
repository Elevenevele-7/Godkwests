import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/council/presentation/council_screen.dart';
import '../features/finance/presentation/finance_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/knowledge/presentation/knowledge_screen.dart';
import '../features/knowledge/presentation/reader_screen.dart';
import '../features/missions/presentation/missions_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/profile/data/profile_repository.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/visions/presentation/visions_screen.dart';
import 'shell_scaffold.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const missions = '/missions';
  static const finance = '/finance';
  static const knowledge = '/knowledge';
  static const profile = '/profile';
  static const visions = '/visions';
  static const council = '/council';
  static String reader(String bookId) => '/reader/$bookId';
}

/// Top-level navigation: the five bottom-bar tabs from the blueprint, plus
/// full-screen pages. New users are sent to onboarding first.
final routerProvider = Provider<GoRouter>((ref) {
  // null while the profile is loading.
  final onboarded = ValueNotifier<bool?>(null);
  ref.listen(
    profileProvider,
    (_, next) => onboarded.value = next.value?.onboarded,
    fireImmediately: true,
  );
  ref.onDispose(onboarded.dispose);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: onboarded,
    redirect: (context, state) {
      final done = onboarded.value;
      final at = state.matchedLocation;
      if (done == null) return at == Routes.splash ? null : Routes.splash;
      if (!done) return at == Routes.onboarding ? null : Routes.onboarding;
      if (at == Routes.splash || at == Routes.onboarding) return Routes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.visions,
        builder: (context, state) => const VisionsScreen(),
      ),
      GoRoute(
        path: Routes.council,
        builder: (context, state) => const CouncilScreen(),
      ),
      GoRoute(
        path: '/reader/:id',
        builder: (context, state) =>
            ReaderScreen(bookId: state.pathParameters['id']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScaffold(shell: shell),
        branches: [
          _tab(Routes.home, const HomeScreen()),
          _tab(Routes.missions, const MissionsScreen()),
          _tab(Routes.finance, const FinanceScreen()),
          _tab(Routes.knowledge, const KnowledgeScreen()),
          _tab(Routes.profile, const ProfileScreen()),
        ],
      ),
    ],
  );
});

StatefulShellBranch _tab(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);
