import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortState {
  date,
  price,
}

final alignState = StateProvider<SortState>((ref) => SortState.date);

class SortIconButton extends ConsumerWidget {
  const SortIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    final sort = ref.watch(alignState);
    return IconButton(
      onPressed: () {
        if (sort == SortState.date) {
          ref.read(storedCustomsNotifierProvider.notifier).sortCustomsByPrice();
          ref.read(alignState.notifier).update((state) => SortState.price);
        } else {
          ref.read(storedCustomsNotifierProvider.notifier).sortCustomsByCreateDate();
          ref.read(alignState.notifier).update((state) => SortState.date);
        }
      },
      icon: sort == SortState.date
          ? const Icon(
              Icons.calendar_month_sharp,
              color: mainColor,
            )
          : const Icon(
              Icons.sort_sharp,
              color: mainColor,
            ),
    );
  }
}
