import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/widgets/inspect_custom/parts_inspect_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/create_custom.dart';

class PartsInspectWidget extends ConsumerWidget {
  const PartsInspectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);

    List<Widget> cells() {
      List<Widget> cells = [];
      custom.align().forEach((key, value) {
        cells.add(PartsInspectCellWidget(key, value));
      });
      cells.add(SizedBox(height: SizeConfig.blockSizeVertical * 5));
      return cells;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells(),
      ),
    );
  }
}
