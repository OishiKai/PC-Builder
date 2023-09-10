import 'package:custom_pc/models/recommend_parameter.dart';
import 'package:custom_pc/providers/edit_custom.dart';
import 'package:custom_pc/providers/search_parameter.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/category_search_parameter.dart';

class RecommendParametersDialog extends ConsumerStatefulWidget {
  const RecommendParametersDialog(this.recommendParameters, {super.key});
  final List<RecommendParameter> recommendParameters;

  @override
  _RecommendParametersDialogState createState() => _RecommendParametersDialogState();
}

class _RecommendParametersDialogState extends ConsumerState<RecommendParametersDialog> {
  @override
  Widget build(BuildContext context) {
    final params = ref.watch(searchParameterNotifierProvider)!;
    final category = ref.watch(searchingCategoryProvider);
    final alignParams = params[category]!.alignParameters();

    // List<PartsSearchParameter>を取り出す工程が煩雑ため、ここから取り出す
    PartsSearchParameter parseParams(int sectionIndex, int paramIndex) {
      return alignParams[sectionIndex].values.expand((element) => element).toList()[paramIndex];
    }

    String sectionName(int paramIndex, int sectionIndex) {
      return alignParams[paramIndex].keys.toList()[sectionIndex];
    }

    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        '選択中のパーツに適した条件',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
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
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (bool? value) {
                          ref.read(searchParameterNotifierProvider.notifier).toggleParameterSelect(
                                params[category]!.alignParameters()[rec.paramSectionIndex].keys.join(''),
                                rec.paramIndex,
                              );
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            '${params[category]!.alignParameters()[rec.paramSectionIndex].keys.join('').split('(')[0]} :',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            parseParams(rec.paramSectionIndex, rec.paramIndex).name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                final custom = ref.read(editCustomNotifierProvider);
                context.pop();
                custom.id == null ? context.pushNamed('create_partsList') : context.pushNamed('partsList', pathParameters: {'id': custom.id!});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '検索',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
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
