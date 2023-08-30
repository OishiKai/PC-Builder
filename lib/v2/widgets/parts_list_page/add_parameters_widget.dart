import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddParametersWidget extends ConsumerWidget {
  const AddParametersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Icon(
            Icons.manage_search_outlined,
            color: Theme.of(context).colorScheme.tertiary,
            size: 30,
          ),
          Text(
            '絞り込み',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
