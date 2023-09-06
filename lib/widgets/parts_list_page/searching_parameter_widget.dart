import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/search_parameter.dart';
import '../../providers/searching_category.dart';

class SearchingParameterWidget extends ConsumerWidget {
  const SearchingParameterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ref.watch(searchParameterNotifierProvider)!;
    final category = ref.watch(searchingCategoryProvider);

    String showText = '表示順 : 人気順';
    final selected = params[category]!.selectedParameterNames();
    if (selected.isNotEmpty) {
      showText = '絞り込み : ${selected.join(', ')}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        showText,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
