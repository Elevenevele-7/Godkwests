import 'package:flutter/material.dart';

import '../domain/advisor.dart';

class CouncilScreen extends StatelessWidget {
  const CouncilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Council')),
      body: ListView(
        children: [
          for (final advisor in Advisor.values)
            ListTile(title: Text(advisor.title), subtitle: Text(advisor.focus)),
        ],
      ),
    );
  }
}
