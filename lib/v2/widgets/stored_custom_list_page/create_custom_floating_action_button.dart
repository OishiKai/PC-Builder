import 'package:custom_pc/v2/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/edit_custom.dart';

class CreateCustomFloatingActionButton extends ConsumerWidget {
  const CreateCustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => false);
        ref.read(editCustomNotifierProvider.notifier).createCustom();
        context.push('/create');
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}
