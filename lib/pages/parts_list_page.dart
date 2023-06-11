import 'package:custom_pc/pages/parts_detail_page.dart';
import 'package:custom_pc/providers/pc_parts_list.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_app_bar.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_cell.dart';
import 'package:custom_pc/widgets/parts_list/search_parameter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../domain/parts_detail_parser.dart';

class PartsListPage extends ConsumerWidget {
  const PartsListPage({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  //final PartsCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final partsList = ref.watch(pcPartsListNotifierProvider);
    return partsList.when(
      data: (partsList) {
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
                    return SearchParameterModal();
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
                      if (partsList[i].fullScaleImages == null) {
                        // 詳細画面用のデータ取得
                        final detailParts = await PartsDetailParser.fetch(partsList[i]);
                        partsList[i] = detailParts;
                        ref.read(pcPartsListNotifierProvider.notifier).updateState(partsList);
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
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}