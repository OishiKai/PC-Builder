import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/custom.dart';
import 'package:custom_pc/providers/pc_parts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/url_builder.dart';
import '../../main.dart';

class SearchParameterModal extends ConsumerStatefulWidget {
  const SearchParameterModal({Key? key}) : super(key: key);

  final _subColor = const Color(0xFFEDECF2);
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  ConsumerState<SearchParameterModal> createState() => _SearchParameterModalState();
}

class _SearchParameterModalState extends ConsumerState<SearchParameterModal> {
  double adjustFontSize(String text) {
    // if (text.contains('\n')) {
    //   final over = text.split('\n')[0];
    //   final under = text.split('\n')[1];
    //   if (over.length > 4 || under.length > 4) {
    //     return 9.2;
    //   }
    //   return 14;
    // }
    // if (text.length > 4) {
    //   return 11.3;
    // }
    return 14;
  }

  @override
  Widget build(BuildContext context) {
    final params = ref.watch(searchParameterProvider)!;
    final alignParams = params.alignParameters();
    final standardPage = params.standardPage();
    // 条件選択時の処理
    void addParameter(CategorySearchParameter params) {
      final url = UrlBuilder.createURLWithParameters(standardPage, params.selectedParameters());
      ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
    }

    // 条件クリア時の処理
    void clearParameter() {
      ref.read(searchParameterProvider.notifier).update((state) => params.clearSelectedParameter());
      ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(standardPage);
    }

    // List<PartsSearchParameter>を取り出す工程が煩雑ため、ここから取り出す
    List<PartsSearchParameter> parseParams(int sectionIndex) {
      return alignParams[sectionIndex].values.expand((element) => element).toList();
    }

    return Container(
      decoration: BoxDecoration(
        color: widget._mainColor,
      ),
      child: DefaultTabController(
        length: alignParams.length,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: widget._mainColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                tabs: <Widget>[
                  for (Map<String, List<PartsSearchParameter>> map in alignParams)
                    Text(
                      map.keys.join(''),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: adjustFontSize(map.keys.join('')),
                      ),
                    ),
                ],
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: widget._mainColor,
              ),
              child: TabBarView(
                children: <Widget>[
                  for (int i = 0; i < alignParams.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: widget._subColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListView(
                          children: [
                            for (int j = 0; j < parseParams(i).length; j++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Checkbox(
                                    value: parseParams(i)[j].isSelect,
                                    activeColor: widget._mainColor,
                                    onChanged: (bool? value) {
                                      final toggled = params.toggleParameterSelect(alignParams[i].keys.join(''), j);
                                      ref.read(searchParameterProvider.notifier).update((state) => toggled);
                                      addParameter(params);
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    parseParams(i)[j].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 65,
              decoration: BoxDecoration(color: widget._mainColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          primary: widget._subColor,
                          onPrimary: widget._mainColor,
                        ),
                        onPressed: () {
                          clearParameter();
                        },
                        child: Text(
                          '条件をクリア',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget._mainColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          primary: widget._subColor,
                          onPrimary: widget._mainColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '戻る',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget._mainColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
