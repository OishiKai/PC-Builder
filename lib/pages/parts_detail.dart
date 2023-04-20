import 'package:custom_pc/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';
import '../widgets/parts_detail/full_scale_image_slider.dart';

class DetailPartsPage extends ConsumerWidget {
  DetailPartsPage(this.partsListIndex, {Key? key}) : super(key: key);
  //PcParts targetParts;
  int partsListIndex;
  //DetailParser parser;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final listProvider = ref.watch(partsListProvider);
    if (listProvider == null) {
      return Scaffold();
    }
    final targetParts = listProvider[partsListIndex];
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FullScaleImageSlider(targetParts.fullScaleImages!),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 30,
                              alignment: Alignment.topLeft,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.leaderboard_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '${targetParts.ranked}位',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      targetParts.maker,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  //color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Text(
                  targetParts.title,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  color: Colors.white10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      targetParts.price.replaceFirst(' ～', ''),
                      style: const TextStyle(color: Colors.red, fontSize: 32),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('(最安値)'),
                        Row(
                          children: const [
                            Text(
                              '前週比：',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '-151円↓',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 8, left: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < targetParts.shops!.length; i++)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('onTap');
                              },
                              child: Container(
                                //width: SizeConfig.blockSizeHorizontal * 50,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   color: Colors.grey[200],
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      height: 25,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 16),
                                          Text(
                                            targetParts.shops![i].shopName,
                                            style: TextStyle(
                                              color: CupertinoColors.link,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              targetParts.shops![i].price,
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(targetParts
                                                .shops![i].bestPriceDiff),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
