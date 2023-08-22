import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/custom_repository.dart';

enum SortState {
  date,
  price,
}

class SortIconButton extends ConsumerWidget {
  SortIconButton({super.key});

  final _alignState = StateProvider<SortState>((ref) => SortState.date);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(_alignState);
    return IconButton(
      onPressed: () {
        if (sort == SortState.date) {
          ref.read(customRepositoryNotifierProvider.notifier).sortCustomsByPrice();
          ref.read(_alignState.notifier).update((state) => SortState.price);
        } else {
          ref.read(customRepositoryNotifierProvider.notifier).sortCustomsByCreateDate();
          ref.read(_alignState.notifier).update((state) => SortState.date);
        }
      },
      icon: sort == SortState.date
          ? Icon(
              Icons.calendar_month_sharp,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            )
          : Icon(
              Icons.sort_sharp,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
    );
  }
}
