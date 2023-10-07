import 'package:custom_pc/providers/edit_custom.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/pc_parts_old.dart';

class SelectForCreateButtonWidget extends ConsumerWidget {
  const SelectForCreateButtonWidget({super.key, required this.parts});
  final PcPartsOld parts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final category = ref.read(searchingCategoryProvider);
        ref.read(editCustomNotifierProvider.notifier).setParts(category, parts);
        context.pop();
        context.pop();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        // side: BorderSide(
        //   color: Theme.of(context).colorScheme.secondary,
        //   width: 5,
        // ),
      ),
      child: Row(
        children: [
          const Spacer(),
          Text(
            "このパーツを選択する",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
