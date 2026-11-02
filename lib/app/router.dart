import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../features/finance/presentation/finance_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/knowledge/presentation/knowledge_screen.dart';
import '../features/missions/presentation/missions_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import 'shell_scaffold.dart';

abstract final class Routes {
  static const home = '/';
  static const missions = '/missions';
  static const finance = '/finance';
  static const knowledge = '/knowledge';
  static const profile = '/profile';
}

/// Top-level navigation: the five bottom-bar tabs from the blueprint.
/// Visions and the AI Council are reached from Home and get their own
/// routes as those features are built.
final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
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

StatefulShellBranch _tab(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);
