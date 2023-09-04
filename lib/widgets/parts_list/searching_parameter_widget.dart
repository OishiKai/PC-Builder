import 'package:custom_pc/providers/search_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchingParameterWidgetOld extends ConsumerWidget {
  const SearchingParameterWidgetOld({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ref.watch(searchParameterProvider);
    if (params == null) {
      return const SizedBox.shrink();
    }

    String showText = '表示順 : 人気順';
    final selected = params.selectedParameterNames();
    if (selected.isNotEmpty) {
      showText = '絞り込み : ${selected.join(', ')}';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        showText,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
