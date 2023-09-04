import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../pages/dashboard.dart';

class EditCancelButton extends ConsumerWidget {
  const EditCancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.close),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
        context.pop();
      },
    );
  }
}
