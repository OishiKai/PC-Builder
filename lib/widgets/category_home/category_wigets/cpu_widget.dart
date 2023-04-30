import 'package:custom_pc/domain/cpu_search_start_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/size_config.dart';
import '../../../domain/detail_parser.dart';
import '../../../domain/url_builder.dart';
import '../../../main.dart';
import '../../../models/pc_parts.dart';
import '../../../pages/parts_detail_page.dart';
import '../../../pages/parts_list_page.dart';
import '../popular_parts_list.dart';

class CpuWidget extends ConsumerWidget {
  const CpuWidget({super.key});

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final categoryHomeData = ref.watch(categoryHomeDataProvider);
    final CpuSearchParameter homeData = categoryHomeData as CpuSearchParameter;
    final partsList = ref.watch(partsListProvider) ?? [];
    searchToPartsListPage(String parameter) async {
      final url = UrlBuilder.buildSearchUrl(PartsCategory.cpu, parameter);
      ref.read(targetUrlProvider.notifier).update((state) => url);
      //ref.read(searchTextProvider.notifier).update((state) => searchText);

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
                '世代',
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
              for (var data in homeData.series.entries)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchToPartsListPage(data.value);
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
                                data.key,
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
              for (var data in homeData.sockets.entries)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchToPartsListPage(data.value);
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
                                data.key,
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
              for (int i = 0; i < partsList.length; i++)
                InkWell(
                  onTap: () async {
                    if (partsList[i].dataFiled == FilledDataProgress.filledForList) {
                      final detail = await DetailParser.create(partsList[i]);
                      partsList[i].fullScaleImages = detail.fullScaleImages;
                      partsList[i].shops = detail.partsShops;
                      partsList[i].specs = detail.specs;
                      partsList[i].dataFiled = FilledDataProgress.filledForDetail;
                      ref.read(partsListProvider.notifier).update((state) => partsList);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPage(partsList[i])));
                  },
                  child: PopularPartsList(partsList[i]),
                )
            ],
          ),
        )
      ],
    );
  }
}
