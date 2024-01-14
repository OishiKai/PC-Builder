import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/edit_custom.dart';
import '../edit_custom_page/parts_compatibility_widget.dart';

class AnalyzeCustomWidget extends ConsumerWidget {
  const AnalyzeCustomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    final customCompatibility = custom.compatibilities;
    return ListView(
      children: [
        // 合計金額部分
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '総計',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              Text(
                custom.formatPrice(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
        // パーツ間の互換性表示部分(互換性情報がない場合は非表示)
        if (customCompatibility != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '分析',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                for (final comp in customCompatibility) PartsCompatibilityWidget(comp),
              ],
            ),
          ),
      ],
    );
  }
}
