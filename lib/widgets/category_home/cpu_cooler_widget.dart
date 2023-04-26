import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../domain/detail_parser.dart';
import '../../domain/url_builder.dart';
import '../../main.dart';
import '../../models/pc_parts.dart';
import '../../pages/parts_detail_page.dart';
import '../../pages/parts_list_page.dart';
import '../parts_list/parts_list_app_bar.dart';

class CpuCoolerWidget extends ConsumerWidget {
  const CpuCoolerWidget({super.key});

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final categoryHomeData = ref.watch(categoryHomeDataProvider);
    final homeData = categoryHomeData.cpuCooler!;

    // 検索バー入力時、キーワードタップ時の画面遷移
    searchToPartsListPage(String text) async {
      final url = UrlBuilder.searchPartsList(Category.graphicsCard, text);
      ref.read(targetUrlProvider.notifier).update((state) => url);
      ref.read(searchTextProvider.notifier).update((state) => text);

      Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPage()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search_outlined,
                size: 24,
                color: _mainColor,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '搭載チップ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _mainColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'NVIDIA',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _mainColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              for (int i = 0; i < homeData.makers.length; i++)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchToPartsListPage(homeData.makers[i]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                homeData.makers[i],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _mainColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.label_important_outlined,
                size: 27,
                color: _mainColor,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '人気製品',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _mainColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GridView.count(
            childAspectRatio: SizeConfig.blockSizeHorizontal * 40 * 0.0045,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < homeData.popularParts.length; i++)
                InkWell(
                  onTap: () async {
                    if (homeData.popularParts[i].dataFiled == FilledDataProgress.filledForList) {
                      final detail = await DetailParser.create(homeData.popularParts[i]);
                      homeData.popularParts[i].fullScaleImages = detail.fullScaleImages;
                      homeData.popularParts[i].shops = detail.partsShops;
                      homeData.popularParts[i].specs = detail.specs;
                      homeData.popularParts[i].dataFiled = FilledDataProgress.filledForDetail;
                      categoryHomeData.cpuCooler = homeData;

                      ref.read(categoryHomeDataProvider.notifier).update((state) => categoryHomeData);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPage(homeData.popularParts[i])));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: Image.network(
                            homeData.popularParts[i].image,
                          ),
                        ),
                        Text(
                          homeData.popularParts[i].maker,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 6),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            homeData.popularParts[i].title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: _mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          homeData.popularParts[i].price,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
