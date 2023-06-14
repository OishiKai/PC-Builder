import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';

class StoredPartsPage extends StatelessWidget {
  const StoredPartsPage(this.partsList, {Key? key}) : super(key: key);
  final List<PcParts> partsList;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('保存したパーツ'),
      ),
      body: ListView.builder(
        itemCount: partsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(partsList[index].image),
            title: Text(partsList[index].title),
            subtitle: Text(partsList[index].price),
          );
        },
      ),
    );
  }
}