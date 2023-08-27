import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../pages/dashboard.dart';

class EditCancelButton extends ConsumerWidget {
  const EditCancelButton({super.key, required this.isCreate});
  final bool isCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void cancelCreate() {
      /// todo: 新規作成キャンセル時
    }

    void cancelEdit() {
      // BottomNavigationBarの表示してからpopする
      ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
      context.pop();
    }

    return IconButton(
      icon: const Icon(Icons.close),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () => isCreate ? cancelCreate() : cancelEdit(),
    );
  }
}
