import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/main.dart';
import 'package:custom_pc/pages/parts_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../models/pc_parts.dart';

class partsListCell extends ConsumerWidget {
  partsListCell(this.partsListIndex, {Key? key}) : super(key: key);
  int partsListIndex;
  List<Icon> stars = [];

  final mainColor = const Color.fromRGBO(60, 130, 80, 1);

  List<Icon> describeStars(PcParts parts) {
    const fullStar = Icon(
      Icons.star,
      color: Colors.orange,
      size: 20,
    );

    const halfStar = Icon(
      Icons.star_half,
      color: Colors.orange,
      size: 20,
    );

    const emptyStar = Icon(
      Icons.star_border_purple500_sharp,
      color: Colors.orange,
      size: 20,
    );

    if (parts.star == null) {
      return List.filled(5, emptyStar);
    }

    final star = parts.star!;

    List<Icon> stars = [];

    final fullStarCount = star ~/ 10;
    final fullStars = List.filled(fullStarCount, fullStar);
    stars.addAll(fullStars);

    if (star % 10 == 0) {
      final emptyStarCount = 5 - fullStarCount;
      final emptyStars = List.filled(emptyStarCount, emptyStar);

      stars.addAll(emptyStars);
    } else {
      stars.add(halfStar);
      final emptyStarCount = 4 - fullStarCount;
      final emptyStars = List.filled(emptyStarCount, emptyStar);
      stars.addAll(emptyStars);
    }

    return stars;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    PcParts? parts;
    final listProvider = ref.watch(partsListProvider);
    if (listProvider == null) {
      return Scaffold();
    }

    parts = listProvider[partsListIndex];
    describeIdentity(parts);
    return Column(
      children: [
        GestureDetector(
            onTap: () async {
              if (parts!.dataFiled == FilledDataProgress.filledForList) {
                final detail = await DetailParser.create(parts);
                parts.fullScaleImages = detail.fullScaleImages;
                parts.shops = detail.partsShops;
                parts.specs = detail.specs;
                parts.dataFiled = FilledDataProgress.filledForDetail;
                listProvider[partsListIndex] = parts;
                ref.watch(partsListProvider.notifier).update((state) => listProvider);
              }
              ref.watch(detailPageProvider.notifier).update((state) => 0);
              final bool? selected = await Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => PartsDetailPage(partsListIndex, stars),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
                    }),
              );
            },
            child: Container(
              // padding: EdgeInsets.all(
              //   SizeConfig.blockSizeHorizontal * 1,
              // ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: stars,
                                ),
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
            )),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
