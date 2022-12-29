import 'package:custom_pc/models/PcPartsDetail.dart';
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
  PcPartsDetail? parts;
  @override
  void initState() {
    super.initState();
    parts = PcPartsDetail(widget.targetParts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('DetailPage')
    );
  }
}


