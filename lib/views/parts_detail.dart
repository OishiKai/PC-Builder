import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/domain/base_parser.dart';
import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/models/pc_parts_detail.dart';
import 'package:custom_pc/views/full_scale_image_slider.dart';
import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../models/pc_parts.dart';

class DetailPartsPage extends StatefulWidget {
  DetailPartsPage(this.targetParts, this.parser, {Key? key}) : super(key: key);
  PcParts targetParts;
  DetailParser parser;

  @override
  State<DetailPartsPage> createState() => _DetailPartsPageState();
}

class _DetailPartsPageState extends State<DetailPartsPage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                      children: [
                        FullScaleImageSlider(widget.parser),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  SizedBox(width: 8,),
                                  Container(
                                    height: 30,
                                    alignment: Alignment.topLeft,
                                    child: ElevatedButton(
                                      onPressed: (){},
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
                                          SizedBox(width: 8,),
                                          Text(
                                            '${widget.targetParts.ranked}位',
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
                          widget.targetParts.maker,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 8,left: 16, right: 16,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      //color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                          widget.targetParts.title,
                          maxLines: 3,
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
                            widget.targetParts.price.replaceFirst(' ～', ''),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 32
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('(最安値)'),
                            Row(
                              children: const [
                                Text(
                                  '前週比：',
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
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
                ],
            ),
        ),
      );
  }
}
