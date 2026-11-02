import 'package:flutter/material.dart';

import 'router.dart';
import 'theme/app_theme.dart';

class AscensionApp extends StatelessWidget {
  const AscensionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ascension',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
