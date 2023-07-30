import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';

class AddPartsModalWidget extends ConsumerWidget {
  const AddPartsModalWidget(this.onTapGrit, {super.key});
  final Function onTapGrit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    Widget categoryGrit(PartsCategory category) {
      Icon categoryIcon;
      switch (category) {
        case PartsCategory.cpu:
          categoryIcon = const Icon(
            Icons.memory,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.cpuCooler:
          categoryIcon = const Icon(
            Icons.ac_unit,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.memory:
          categoryIcon = const Icon(
            Icons.straighten,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.motherBoard:
          categoryIcon = const Icon(
            Icons.dashboard_outlined,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.graphicsCard:
          categoryIcon = const Icon(
            Icons.wallpaper,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.ssd:
          categoryIcon = const Icon(
            Icons.sd_card_outlined,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.powerUnit:
          categoryIcon = const Icon(
            Icons.power_outlined,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.pcCase:
          categoryIcon = const Icon(
            Icons.inventory_2_outlined,
            color: Colors.white,
            size: 45,
          );
          break;
        case PartsCategory.caseFan:
          categoryIcon = const Icon(
            Icons.air_rounded,
            color: Colors.white,
            size: 45,
          );
          break;
      }
      return Column(
        children: [
          Container(
            height: SizeConfig.blockSizeHorizontal * 20,
            width: SizeConfig.blockSizeHorizontal * 20,
            child: ElevatedButton(
              onPressed: () {
                onTapGrit(category);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
              ),
              child: categoryIcon,
            ),
          ),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              category.categoryShortName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
        height: SizeConfig.blockSizeVertical * 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Row(
            children: [
              const Text(
                'パーツを追加',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Text(
            'カテゴリから選択',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var category in PartsCategory.values) categoryGrit(category),
              ],
            ),
          ),
        ]));
  }
}
