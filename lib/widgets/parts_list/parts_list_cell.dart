import 'package:custom_pc/widgets/parts_detail/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../models/pc_parts.dart';
import '../../providers/pc_parts_list.dart';

class PartsListCell extends ConsumerWidget {
  const PartsListCell(this.parts, {Key? key}) : super(key: key);
  final PcParts parts;
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final partsList = ref.watch(pcPartsListNotifierProvider);

    // return partsList.when(
    //   data:(parts) {
        
    //   },
    //   loading: () => const Center(child: CircularProgressIndicator()),
      
    // );
    return Column(
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
                    Container(width: SizeConfig.blockSizeHorizontal * 45, height: 160 - SizeConfig.blockSizeHorizontal * 0.5, child: Image.network(parts.image)),
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
                              parts.maker,
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
                              visible: parts.isNew,
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
                          parts.title,
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
                            StarWidget(parts.star),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  parts.evaluation ?? '-',
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
                            parts.price,
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
    );
  }
}
