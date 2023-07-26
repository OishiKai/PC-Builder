import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/pc_parts.dart';
import '../../providers/create_custom.dart';
import '../../providers/searching_category.dart';

class SelectForCreateButtonWidget extends ConsumerWidget {
  const SelectForCreateButtonWidget(this.parts, {super.key});
  final PcParts parts;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final category = ref.read(searchingCategoryProvider);
        ref.read(createCustomNotifierProvider.notifier).setParts(category, parts);
        int count = 0;
        ref.read(createCustomNotifierProvider.notifier).updateCompatibilities();
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
      child: Row(
        children: const [
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
