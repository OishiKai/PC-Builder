import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/edit_custom.dart';
import '../../domain/parameter_recommender.dart';
import '../../models/parts_category.dart';
import '../../providers/search_parameter.dart';
import '../../providers/searching_category.dart';
import '../edit_custom_page/recommend_parameters_dialog.dart';

class AddPartsDialog extends ConsumerWidget {
  const AddPartsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);

    return SimpleDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: const Text('カテゴリーを選択'),
      children: [
        for (final category in PartsCategory.values)
          SimpleDialogOption(
            onPressed: () {
              // 検索対象のカテゴリ設定
              ref.read(searchingCategoryProvider.notifier).update((state) => category);

              // 検索パラメータ取得
              final params = ref.read(searchParameterNotifierProvider)![category]!;
              // パラメータの選択状態をクリア
              ref.read(searchParameterNotifierProvider.notifier).clearSelectedParameter();

              // 選択中のパーツにあったパラメータを取得
              final recommend = ParameterRecommender(custom, category, params);
              if (recommend.recommendedParameters.isNotEmpty) {
                // パラメータがある場合は、パラメータを選択状態にする
                for (final rec in recommend.recommendedParameters) {
                  ref.read(searchParameterNotifierProvider.notifier).toggleParameterSelect(
                        params.alignParameters()[rec.paramSectionIndex].keys.join(''),
                        rec.paramIndex,
                      );
                }
                // このダイアログを閉じて、パラメータ選択ダイアログを開く
                context.pop();
                showDialog(context: context, builder: (context) => RecommendParametersDialog(recommend.recommendedParameters));
              } else {
                // パラメータがない場合は、検索画面に遷移
                context.pop();
                custom.id == null ? context.pushNamed('create_partsList') : context.pushNamed('partsList', pathParameters: {'id': custom.id!});
              }
            },
            child: Row(
              children: [
                Icon(
                  custom.get(category) == null ? Icons.add : Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(category.categoryShortName),
              ],
            ),
          ),
      ],
    );
  }
}
