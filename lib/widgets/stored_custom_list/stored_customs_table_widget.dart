import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/providers/detail_page_usage.dart';
import 'package:custom_pc/providers/editing_custom_id.dart';
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
        if (data.isEmpty) {
          return Container(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '保存済みカスタムはありません',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }

        List<Widget> cells() {
          final List<Widget> cells = [];
          data.forEach((key, value) {
            cells.add(InkWell(
              onTap: () {
                ref.read(editingCustomIdNotifierProvider.notifier).setState(key);
                ref.read(detailPageUsageNotifierProvider.notifier).switchView();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const InspectCustomPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                      }),
                );
              },
              child: CustomCellWidget(value),
            ));
          });
          final List<Widget> cellList = List.from(cells.reversed);
          cellList.add(SizedBox(height: SizeConfig.blockSizeVertical * 7));
          return cellList;
        }

        return Container(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFEDECF2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            children: cells(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}
