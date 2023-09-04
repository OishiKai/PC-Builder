import 'package:custom_pc/providers/edit_custom.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/pc_parts.dart';

class SelectForCreateButtonWidget extends ConsumerWidget {
  const SelectForCreateButtonWidget({super.key, required this.parts});
  final PcParts parts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final category = ref.read(searchingCategoryProvider);
        ref.read(editCustomNotifierProvider.notifier).setParts(category, parts);
        int count = 0;
        Navigator.popUntil(context, (_) => count++ >= 2);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        side: const BorderSide(
          color: Colors.green,
          width: 5,
        ),
      ),
      child: const Row(
        children: [
          Spacer(),
          Text(
            "このパーツを選択する",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
