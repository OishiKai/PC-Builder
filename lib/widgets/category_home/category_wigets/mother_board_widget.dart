import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/size_config.dart';
import '../../../domain/detail_parser.dart';
import '../../../domain/url_builder.dart';
import '../../../main.dart';
import '../../../models/pc_parts.dart';
import '../../../pages/parts_detail_page.dart';
import '../../../pages/parts_list_page.dart';
import '../../parts_list/parts_list_app_bar.dart';
import '../popular_parts_list.dart';

class MotherBoardWidget extends ConsumerWidget {
  const MotherBoardWidget({super.key});

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final categoryHomeData = ref.watch(categoryHomeDataProvider);
    final homeData = categoryHomeData.motherBoard!;

    // 検索バー入力時、キーワードタップ時の画面遷移
    searchToPartsListPage(String text) async {
      final url = UrlBuilder.searchPartsList(PartsCategory.motherBoard, text);
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
                'CPUソケット',
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
            'intel',
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
              for (int i = 0; i < homeData.intelSocket.length; i++)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchToPartsListPage(homeData.intelSocket[i]);
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
                                homeData.intelSocket[i],
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
          child: Text(
            'AMD',
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
              for (int i = 0; i < homeData.amdSocket.length; i++)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchToPartsListPage(homeData.amdSocket[i]);
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
                                homeData.amdSocket[i],
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
                    )
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
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
                      categoryHomeData.motherBoard = homeData;

                      ref.read(categoryHomeDataProvider.notifier).update((state) => categoryHomeData);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPage(homeData.popularParts[i])));
                  },
                  child: PopularPartsList(homeData.popularParts[i]),
                )
            ],
          ),
        )
      ],
    );
  }
}
