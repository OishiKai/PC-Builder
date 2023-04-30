import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_detail_page.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_app_bar.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../main.dart';
import '../widgets/parts_list/parameter_select_modal.dart';

class PartsListPage extends ConsumerWidget {
  const PartsListPage({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  //final PartsCategory category;

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
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return ParameterSelectModal();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                primary: _mainColor,
              ),
              child: Row(
                children: const [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '絞り込み',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
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
          ),
        ],
      ),
    );
  }
}
