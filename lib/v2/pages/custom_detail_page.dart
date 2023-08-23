import 'package:custom_pc/v2/providers/custom_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDetailPage extends ConsumerWidget {
  const CustomDetailPage({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(customRepositoryNotifierProvider);
    return custom.when(
      data: (data) {
        final custom = data.firstWhere((element) => element.id == id);
        return Scaffold(
          appBar: AppBar(
            title: const Text('カスタムの詳細'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                custom.name!,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (e, s) {
        return const Center(
          child: Text('読み込みに失敗しました'),
        );
      },
    );
  }
}
