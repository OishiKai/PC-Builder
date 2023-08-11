import 'package:custom_pc/models/recommend_parameter.dart';
import 'package:custom_pc/providers/search_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/url_builder.dart';
import '../../models/category_search_parameter.dart';
import '../../pages/parts_list_page.dart';
import '../../providers/pc_parts_list.dart';

class RecommendParametersDialog extends ConsumerStatefulWidget {
  const RecommendParametersDialog(this.recommendParameters, {super.key});
  final List<RecommendParameter> recommendParameters;

  @override
  _RecommendParametersDialogState createState() => _RecommendParametersDialogState();
}

class _RecommendParametersDialogState extends ConsumerState<RecommendParametersDialog> {
  // @override
  // void initState() {
  //   super.initState();
  //   final params = ref.read(searchParameterProvider)!;
  //   for (final rec in widget.recommendParameters) {
  //     final paramName = params.alignParameters()[rec.paramSectionIndex].keys.join('');
  //     ref.read(searchParameterProvider.notifier).toggleParameterSelect(paramName, rec.paramIndex);
  //   }
  //   final url = UrlBuilder.createURLWithParameters(params.standardPage(), params.selectedParameters());
  //   ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
  // }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    final params = ref.watch(searchParameterProvider)!;
    final alignParams = params.alignParameters();

    // List<PartsSearchParameter>を取り出す工程が煩雑ため、ここから取り出す
    PartsSearchParameter parseParams(int sectionIndex, int paramIndex) {
      return alignParams[sectionIndex].values.expand((element) => element).toList()[paramIndex];
    }

    String sectionName(int paramIndex, int sectionIndex) {
      return alignParams[paramIndex].keys.toList()[sectionIndex];
    }

    // 条件選択時の処理
    void addParameter(CategorySearchParameter params) async {
      final url = UrlBuilder.createURLWithParameters(params.standardPage(), params.selectedParameters());
      await ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
    }

    return SimpleDialog(
      //contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        '選択中のパーツに適した条件',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Column(
              children: [
                for (final rec in widget.recommendParameters)
                  Row(
                    children: [
                      Checkbox(
                        value: parseParams(rec.paramSectionIndex, rec.paramIndex).isSelect,
                        activeColor: mainColor,
                        onChanged: (bool? value) {
                          ref.read(searchParameterProvider.notifier).toggleParameterSelect(params.alignParameters()[rec.paramSectionIndex].keys.join(''), rec.paramIndex);
                          addParameter(params);
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            '${params.alignParameters()[rec.paramSectionIndex].keys.join('').replaceFirst('\n', '')} :',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            parseParams(rec.paramSectionIndex, rec.paramIndex).name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'キャンセル',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '検索',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
