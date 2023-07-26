import 'package:custom_pc/pages/parts_detail_page.dart';
import 'package:custom_pc/providers/detail_page_usage.dart';
import 'package:custom_pc/widgets/parts_detail/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../domain/parts_detail_parser.dart';
import '../../providers/pc_parts_list.dart';

class PartsListWidget extends ConsumerWidget {
  const PartsListWidget({super.key});
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final partsList = ref.watch(pcPartsListNotifierProvider);

    void showProgressDialog() {
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            );
          });
    }

    return partsList.when(
      data: (parts) {
        return Expanded(
          child: ListView(children: [
            for (int i = 0; i < parts.length; i++)
              GestureDetector(
                onTap: () async {
                  // プログレスサークル表示
                  showProgressDialog();

                  // 詳細画面用のデータ取得
                  if (parts[i].fullScaleImages == null) {
                    final detailParts = await PartsDetailParser.fetch(parts[i]);
                    parts[i] = detailParts;
                    ref.read(pcPartsListNotifierProvider.notifier).updateState(parts);
                  }
                  ref.read(detailPageUsageNotifierProvider.notifier).switchCreate();
                  // プログレスサークル非表示
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPage(parts[i])));
                },
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: SizeConfig.blockSizeHorizontal * 98,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFEDECF2),
                            width: 1,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              SizeConfig.blockSizeHorizontal * 1,
                            ),
                            child: Stack(
                              children: [
                                Container(width: SizeConfig.blockSizeHorizontal * 45, height: 160 - SizeConfig.blockSizeHorizontal * 0.5, child: Image.network(parts[i].image)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 1,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDECF2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 16,
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          parts[i].maker,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor,
                                          ),
                                        ),
                                        Visibility(
                                          visible: parts[i].isNew,
                                          child: Container(
                                            //padding: EdgeInsets.all(2),
                                            height: 14,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Text(
                                              'NEW',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      parts[i].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 26,
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        StarWidget(parts[i].star),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            parts[i].evaluation ?? '-',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: mainColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: SizedBox(
                                      height: 25,
                                      width: double.infinity,
                                      child: Text(
                                        parts[i].price,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
          ]),
        );
      },
      loading: () => const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(60, 130, 80, 1)),
      ),
      error: (error, stackTrace) => Container(),
    );
  }
}
