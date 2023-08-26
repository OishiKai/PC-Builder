import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditCustomPageV2 extends ConsumerWidget {
  const EditCustomPageV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(custom.name ?? 'New Custom'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            context.go('/home/detail/${custom.id}');
          },
        ),
      ),
      body: const Center(
        child: Text('Edit Custom Page'),
      ),
    );
  }
}
