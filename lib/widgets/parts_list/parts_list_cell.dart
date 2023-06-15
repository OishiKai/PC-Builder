import 'package:custom_pc/database/pc_parts_repository.dart';
import 'package:custom_pc/widgets/parts_detail/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../domain/parts_detail_parser.dart';
import '../../pages/parts_detail_page.dart';
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
            return Center(
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
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Visibility(
                                          visible: parts[i].isNew,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            height: 14,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Text(
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
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        //color: Colors.blue,
                                        ),
                                    child: Row(
                                      children: [
                                        StarWidget(parts[i].star),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              parts[i].evaluation ?? '-',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Container(
                                      height: 25,
                                      width: double.infinity,
                                      child: Text(
                                        parts[i].price,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
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
                    SizedBox(
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
