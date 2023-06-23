import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_cell.dart';

class StoredCustomsListWidget extends ConsumerWidget {
  const StoredCustomsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedCustoms = ref.watch(storedCustomsNotifierProvider);
    SizeConfig().init(context);
    return storedCustoms.when(
      data: (data) {
        List<CustomCellWidget> cells() {
          final List<CustomCellWidget> cells = [];
          data.forEach((key, value) {
            cells.add(CustomCellWidget(value));
          });
          return cells;
        }

        return Container(
          padding: const EdgeInsets.only(top: 16),
          height: SizeConfig.blockSizeVertical * 78,
          decoration: BoxDecoration(
            color: const Color(0xFFEDECF2),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: ListView(
              padding: EdgeInsets.zero,
              children: cells(),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}
