import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pages/dashboard.dart';
import '../../providers/custom_repository.dart';
import '../../providers/edit_custom.dart';

class SaveIconButton extends ConsumerWidget {
  const SaveIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);

    // カスタムの新規作成時
    void createNewCustom() {
      // 編集中のカスタムを保存
      ref.read(customRepositoryNotifierProvider.notifier).addCustom(custom);
      // bottomNavigationBarを表示
      ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
      Navigator.of(context).pop();
      // SnackBarを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'カスタムを作成しました',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'NotoSansJP',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          duration: const Duration(seconds: 1),
        ),
      );
    }

    // カスタムの更新時
    void updateCustom() {
      // 編集中のカスタムを保存
      ref.read(customRepositoryNotifierProvider.notifier).updateCustom(custom);
      // bottomNavigationBarを表示
      ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
      Navigator.of(context).pop();
      // SnackBarを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'カスタムを更新しました',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'NotoSansJP',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          duration: const Duration(seconds: 1),
        ),
      );
    }

    return IconButton(
      onPressed: () {
        // パーツが選択されていない場合
        if (custom.isEmpty()) {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Text(
                  'パーツを選択してください',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ],
              );
            },
          );
          return;
        }
        // パーツが選択されている場合、新規作成or更新で分岐
        custom.id == null ? createNewCustom() : updateCustom();
      },
      icon: Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.primary,
        size: 32,
      ),
    );
  }
}
