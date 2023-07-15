import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/providers/create_custom.dart';
import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/inspect_custom_page.dart';
import 'custom_cell.dart';

class StoredCustomsListWidget extends ConsumerWidget {
  const StoredCustomsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedCustoms = ref.watch(storedCustomsNotifierProvider);

    SizeConfig().init(context);
    return storedCustoms.when(
      data: (data) {
        List<Widget> cells() {
          final List<Widget> cells = [];
          data.forEach((key, value) {
            cells.add(InkWell(
              onTap: () {
                ref.read(createCustomNotifierProvider.notifier).updateState(value);
                ref.read(createCustomNotifierProvider.notifier).updateCompatibilities();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => InspectCustomPage(key),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                      }),
                );
              },
              child: CustomCellWidget(value),
            ));
          });
          return cells;
        }

        return Container(
          padding: const EdgeInsets.only(top: 16),
          height: SizeConfig.blockSizeVertical * 77,
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
