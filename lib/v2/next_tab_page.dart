import 'package:flutter/material.dart';

class NextTabPage extends StatelessWidget {
  const NextTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: const Center(child: Text('Next Tab Page')),
    );
  }
}
