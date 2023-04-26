import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_detail_page.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_app_bar.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../main.dart';

class PartsListPage extends ConsumerWidget {
  const PartsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final partsList = ref.watch(partsListProvider);
    if (partsList == null) {
      return Scaffold(
        appBar: PartsListAppBar(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PartsListAppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 16,
        ),
        children: [
          for (int i = 0; i < partsList.length; i++)
            GestureDetector(
              onTap: () async {
                if (partsList[i].dataFiled == FilledDataProgress.filledForList) {
                  // 詳細画面用のデータ取得
                  final detail = await DetailParser.create(partsList[i]);
                  partsList[i].fullScaleImages = detail.fullScaleImages;
                  partsList[i].shops = detail.partsShops;
                  partsList[i].specs = detail.specs;
                  partsList[i].dataFiled = FilledDataProgress.filledForDetail;
                  // プロバイダーを更新
                  ref.read(partsListProvider.notifier).update((state) => partsList);
                }
                Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPage(partsList[i])));
              },
              child: PartsListCell(partsList[i]),
            )
        ],
      ),
    );
  }
}
