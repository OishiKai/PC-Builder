import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ref.read(storedCustomsNotifierProvider.notifier).sortCustomsByPrice();
          ref.read(_alignState.notifier).update((state) => SortState.price);
        } else {
          ref.read(storedCustomsNotifierProvider.notifier).sortCustomsByCreateDate();
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
