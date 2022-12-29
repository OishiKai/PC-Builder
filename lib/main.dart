import 'package:custom_pc/domain/parts_list_parser.dart';
import 'package:custom_pc/views/parts_list_cell.dart';
import 'package:flutter/material.dart';
import '/config/size_config.dart';
import 'models/pc_parts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: scrapeParts(),
    );
  }
}

class scrapeParts extends StatefulWidget {
  const scrapeParts({Key? key}) : super(key: key);

  @override
  State<scrapeParts> createState() => _scrapePartsState();
}

class _scrapePartsState extends State<scrapeParts> {
  String partsListUrl = 'https://kakaku.com/search_results/%83O%83%89%83t%83B%83b%83N%83%7B%81%5B%83h/?category=0001%2C0028&act=Suggest';
  List<PcParts> partsList = [];

  Future<void> fetchPartsList(String url) async{
    final parser = await PartsListParser.create(url);
    partsList = parser.setUpViews();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPartsList(partsListUrl);
    print(partsList.length);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      
      appBar: AppBar(),

      body: ListView.builder(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1,),
          itemCount: partsList.length,
          itemBuilder: (BuildContext context, int index) {
            final cell = partsListCell(partsList[index]);
            cell.stars = cell.describeStars(cell.parts);
            return cell;
          }
      ),
    );
  }
}

