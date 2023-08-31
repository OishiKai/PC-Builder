import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/v2/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/edit_custom.dart';

class AddPartsDialog extends ConsumerWidget {
  const AddPartsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);

    void selectForCreate() {
      ref.read(searchingCategoryProviderV2.notifier).update((state) => category);
      context.pop();
      context.pushNamed('partsList', pathParameters: {'id': custom.id!});
    }

    void selectForEdit() {
      ref.read(searchingCategoryProviderV2.notifier).update((state) => category);
      context.pop();
      context.pushNamed('partsList', pathParameters: {'id': custom.id!});
    }

    return SimpleDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text('カテゴリーを選択'),
      children: [
        for (final category in PartsCategory.values)
          SimpleDialogOption(
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  custom.get(category) == null ? Icons.add : Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(category.categoryShortName),
              ],
            ),
          ),
      ],
    );
  }
}
