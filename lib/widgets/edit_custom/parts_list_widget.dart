import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/widgets/edit_custom/parts_list_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/create_custom.dart';

class PartsListWidget extends ConsumerWidget {
  const PartsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);

    List<Widget> cells() {
      List<Widget> cells = [];
      custom.align().forEach((key, value) {
        cells.add(PartsListCellWidget(key, value));
      });
      cells.add(SizedBox(height: SizeConfig.blockSizeVertical * 5));
      return cells;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      decoration: const BoxDecoration(
        color: Color(0xFFEDECF2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells(),
      ),
    );
  }
}
