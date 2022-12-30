import 'package:custom_pc/domain/base_parser.dart';
import 'package:custom_pc/domain/detail_parser.dart';
import 'package:custom_pc/models/pc_parts_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/pc_parts.dart';
class DetailPartsPage extends StatefulWidget {
  DetailPartsPage(this.targetParts, {Key? key}) : super(key: key);
  PcParts targetParts;

  @override
  State<DetailPartsPage> createState() => _DetailPartsPageState();
}

class _DetailPartsPageState extends State<DetailPartsPage> {
  PcParts? parts;
  @override
  void initState() {
    super.initState();
    this.parts = widget.targetParts;
    final parser = DetailParser.create(parts!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('DetailPage')
    );
  }
}


