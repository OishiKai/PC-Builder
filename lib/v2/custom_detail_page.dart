import 'package:custom_pc/v2/providers/focus_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDetailPage extends ConsumerWidget {
  const CustomDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(focusCustomProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('カスタムの詳細'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(custom.name!),
      ),
    );
  }
}
