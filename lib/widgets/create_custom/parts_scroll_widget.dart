import 'package:custom_pc/main.dart';
import 'package:custom_pc/models/custom_old.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_list_page.dart';
import 'package:custom_pc/providers/create_custom.dart';
import 'package:custom_pc/providers/pc_parts_list.dart';
import 'package:custom_pc/providers/search_parameters.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';

class PartsScrollWidget extends ConsumerWidget {
  const PartsScrollWidget({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);

    setupToPartsListPage(PartsCategory category) async {
      // ここで検索を始めるパーツカテゴリを設定する
      ref.read(searchingCategoryProvider.notifier).changeCategory(category);
      // カテゴリに合わせて検索URL、パラメータを設定する
      ref.read(pcPartsListNotifierProvider.notifier).switchCategory(category);
      ref.read(searchParameterProvider.notifier).replaceParameters(category);
    }

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification notification) {
        notification.disallowGlow();
        return false;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        primary: false,
        child: Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            ),
            for (int i = 0; i < PartsCategory.values.length; i++)
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
                child: InkWell(
                  onTap: () async {
                    setupToPartsListPage(PartsCategory.values[i]);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PartsListPage()));
                  },
                  child: Container(
                    // 4%, 28%, 4%, 28%, 4%, 28%, 4% の横幅で表示する
                    width: SizeConfig.blockSizeHorizontal * 35,
                    // 横幅の1.35倍の縦幅とする
                    height: SizeConfig.blockSizeHorizontal * 35 * 1.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            PartsCategory.values[i].categoryShortName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _mainColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (custom.get(PartsCategory.values[i]) != null)
                          Image.network(
                            custom.get(PartsCategory.values[i])!.image,
                            width: SizeConfig.blockSizeHorizontal * 24,
                            height: SizeConfig.blockSizeHorizontal * 24,
                            fit: BoxFit.contain,
                          ),
                        if (custom.get(PartsCategory.values[i]) == null)
                          Icon(
                            Icons.add_circle,
                            size: 38,
                            color: _mainColor,
                          ),
                        const Spacer(),
                        if (custom.get(PartsCategory.values[i]) != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                            child: Text(
                              custom.get(PartsCategory.values[i])!.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (custom.get(PartsCategory.values[i]) != null)
                          Text(
                            custom.get(PartsCategory.values[i])!.price,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        if (custom.get(PartsCategory.values[i]) == null)
                          const Text(
                            '¥-',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  String _shortName(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return category.categoryName;
      case PartsCategory.cpuCooler:
        return 'CPUクーラー';
      case PartsCategory.memory:
        return 'メモリ';
      case PartsCategory.motherBoard:
        return 'マザボ';
      case PartsCategory.graphicsCard:
        return 'グラボ';
      case PartsCategory.ssd:
        return category.categoryName;
      case PartsCategory.pcCase:
        return category.categoryName;
      case PartsCategory.powerUnit:
        return '電源';
      case PartsCategory.caseFan:
        return category.categoryName;
    }
  }
}
