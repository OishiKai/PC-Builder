import 'package:custom_pc/pages/parts_list_cell.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../main.dart';
import '../models/pc_parts.dart';

class PartsListPage extends ConsumerWidget {
  PartsListPage(this.partsListUrl, {super.key});

  final String partsListUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    bool isExpand = false;
    List<PcParts> partsList = [];
    final partsListProvider = ref.watch(partsListFutureProvider);
    if (partsListProvider.value != null) {
      partsList = partsListProvider.value!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PartsListAppBar(),
      body: ListView.builder(
          padding: EdgeInsets.only(
            top: 16,
          ),
          itemCount: partsList.length,
          itemBuilder: (BuildContext context, int index) {
            final cell = partsListCell(index);
            cell.stars = cell.describeStars(
                ref.watch(partsListFutureProvider).value![index]);
            return cell;
          }),
    );
  }
}
