import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/domain/base_parser.dart';
import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/models/pc_parts_detail.dart';
import 'package:custom_pc/views/full_scale_image_slider.dart';
import 'package:flutter/material.dart';

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
                  FullScaleImageSlider(widget.parser),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Text(
                          'ASRock',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 112,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'PowerColor Red Devil AMD Radeon RX 7900 XTX 24GB GDDR6 Limited Edition RX7900XTX 24G-E/OC/LIMITED [PCIExp 24GB]',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(16),
                    child: Text(
                        '¥155,999',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32
                      ),
                    ),
                  ),
                ],
            ),
        ),
      );
  }


}
