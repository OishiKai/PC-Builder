import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../pages/dashboard.dart';
import '../../providers/edit_custom.dart';

class EditCancelButton extends ConsumerWidget {
  const EditCancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    final isCreate = custom.id == null;

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
      // customのidがnullかどうかで新規作成か編集か判断
      onPressed: () => isCreate ? cancelCreate() : cancelEdit(),
    );
  }
}
