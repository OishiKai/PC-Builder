import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/widgets/stored_custom_list/custom_tile.dart';
import 'package:flutter/material.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({Key? key}) : super(key: key);
  //final Custom custom;

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.tune_sharp,
                    size: 35,
                    color: mainColor,
                  ),
                ),
                const Spacer(),
                const Text(
                  'ライブラリ',
                  style: TextStyle(
                    fontSize: 18,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.more_vert_outlined,
                    size: 35,
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(top: 16),
            height: SizeConfig.blockSizeVertical * 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEDECF2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return const CustomTile();
              },
            ),
          ),
        ],
      ),
    ));
  }
}
