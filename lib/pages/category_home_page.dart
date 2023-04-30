import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_list_page.dart';
import 'package:custom_pc/widgets/category_home/category_wigets/cpu_cooler_widget.dart';
import 'package:custom_pc/widgets/category_home/category_wigets/graphics_card_widget.dart';
import 'package:custom_pc/widgets/category_home/category_wigets/mother_board_widget.dart';
import 'package:custom_pc/widgets/category_home/category_wigets/ssd_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/url_builder.dart';
import '../main.dart';
import '../widgets/category_home/category_wigets/cpu_widget.dart';
import '../widgets/parts_list/parts_list_app_bar.dart';

class CategoryHomePage extends ConsumerWidget {
  CategoryHomePage(
    this.category, {
    super.key,
  });

  final PartsCategory category;
  final _controller = TextEditingController();
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final _subColor = const Color(0xFFEDECF2);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);

    Widget? categoryHomeWidget() {
      switch (category) {
        case PartsCategory.cpu:
          return const CpuWidget();
        case PartsCategory.cpuCooler:
          return const CpuCoolerWidget();
        case PartsCategory.memory:
          // TODO: Handle this case.
          break;
        case PartsCategory.motherBoard:
          return const MotherBoardWidget();
          break;
        case PartsCategory.graphicsCard:
          return const GraphicsCardWidget();
          break;
        case PartsCategory.ssd:
          return const SsdWidget();
          break;
        case PartsCategory.pcCase:
          // TODO: Handle this case.
          break;
        case PartsCategory.powerUnit:
          // TODO: Handle this case.
          break;
        case PartsCategory.caseFan:
          // TODO: Handle this case.
          break;
        case PartsCategory.monitor:
          // TODO: Handle this case.
          break;
      }
      return null;
    }

    return Scaffold(
      backgroundColor: _mainColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _subColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 16),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: _mainColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _mainColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: TextField(
                              controller: _controller,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                contentPadding: EdgeInsets.only(top: 14, left: 8.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (text) {
                                final trim = text.trim();
                                if (text == '') {
                                  return;
                                }
                                final url = UrlBuilder.searchPartsList(category, trim);
                                ref.read(targetUrlProvider.notifier).update((state) => url);
                                ref.read(searchTextProvider.notifier).update((state) => text);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPage()));
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.categoryName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                      ),
                    ),
                    categoryHomeWidget()!,
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
