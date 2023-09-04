import 'package:custom_pc/domain/parameter_recommender.dart';
import 'package:custom_pc/old/widgets/create_custom/total_price_widget.dart';
import 'package:custom_pc/old/widgets/edit_custom/recommend_parameters_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/size_config.dart';
import '../../../domain/url_builder.dart';
import '../../../models/pc_parts.dart';
import '../../../widgets/edit_custom_page/parts_compatibility_widget.dart';
import '../../pages/parts_list_page.dart';
import '../../providers/create_custom.dart';
import '../../providers/pc_parts_list.dart';
import '../../providers/search_parameters.dart';
import '../../providers/searching_category.dart';
import 'add_parts_modal_widget.dart';

class CustomSummaryPanelWidget extends ConsumerWidget {
  const CustomSummaryPanelWidget({super.key});

  void showProgressDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);
    final comps = custom.compatibilities;
    //final params = ref.watch(searchParameterProvider);

    onTapGrit(PartsCategory category) async {
      showProgressDialog(context);
      // ここで検索を始めるパーツカテゴリを設定する
      ref.read(searchingCategoryProviderOld.notifier).changeCategory(category);
      // カテゴリに合わせて検索URL、パラメータを設定する
      ref.read(pcPartsListNotifierProvider.notifier).switchCategory(category);
      await ref.read(searchParameterProvider.notifier).replaceParameters(category);
      final params = ref.read(searchParameterProvider);
      // すでに選択済みのパーツの中で、検索対象のパーツで絞り込みできるかチェック
      final recommend = ParameterRecommender(custom, category, params!).recommendedParameters;
      // プログレスサークル非表示
      Navigator.of(context).pop();
      if (recommend.isNotEmpty) {
        for (final rec in recommend) {
          final paramName = params.alignParameters()[rec.paramSectionIndex].keys.join('');
          ref.read(searchParameterProvider.notifier).toggleParameterSelect(paramName, rec.paramIndex);
        }
        final url = UrlBuilder.createURLWithParameters(params.standardPage(), params.selectedParameters());
        ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return RecommendParametersDialog(recommend);
          },
        );
      } else {
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPageOld()));
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 2.5,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_up_sharp,
              color: Color.fromRGBO(60, 130, 80, 1),
              size: 30,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 42.5,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 13,
                width: SizeConfig.blockSizeHorizontal * 15,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return AddPartsModalWidget(onTapGrit);
                      },
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 42.5,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    custom.formatPrice(),
                    style: const TextStyle(
                      color: Color.fromRGBO(9, 109, 54, 1),
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 43,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: const TabBar(
                  indicatorColor: Color.fromRGBO(60, 130, 80, 1),
                  labelColor: Color.fromRGBO(60, 130, 80, 1),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                        child: Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                    Tab(
                        child: Text(
                      'Compatibility',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ],
                ),
                body: Container(
                  height: SizeConfig.blockSizeVertical * 37,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(45),
                        bottomLeft: Radius.circular(45),
                      )),
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Container(alignment: Alignment.topCenter, child: TotalPriceWidget()),
                      ),
                      if (comps!.isNotEmpty)
                        ListView(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            for (int i = 0; i < comps.length; i++) PartsCompatibilityWidget(comps[i]),
                          ],
                        ),
                      if (comps.isEmpty)
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No compatibility',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
