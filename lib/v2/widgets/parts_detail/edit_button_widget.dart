import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/searching_category.dart';

class EditButtonWidget extends ConsumerWidget {
  const EditButtonWidget({super.key, required this.category});

  final PartsCategory category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    return ElevatedButton(
      onPressed: () {
        // // カテゴリに合わせて検索URL、パラメータを設定する
        // ref.read(pcPartsListNotifierProvider.notifier).switchCategory(category);
        // await ref.read(searchParameterProvider.notifier).replaceParameters(category);
        //
        // // // 一旦編集画面に戻ってからパーツ一覧画面に遷移する
        // // Navigator.of(context).pop();
        // // Navigator.push(context, MaterialPageRoute(builder: (context) => const PartsListPage()));
        //
        // final params = ref.read(searchParameterProvider);
        // // すでに選択済みのパーツの中で、検索対象のパーツで絞り込みできるかチェック
        // final recommend = ParameterRecommender(custom, category, params!).recommendedParameters;
        // // // プログレスサークル非表示
        // // Navigator.of(context).pop();
        // if (recommend.isNotEmpty) {
        //   for (final rec in recommend) {
        //     final paramName = params.alignParameters()[rec.paramSectionIndex].keys.join('');
        //     ref.read(searchParameterProvider.notifier).toggleParameterSelect(paramName, rec.paramIndex);
        //   }
        //   final url = UrlBuilder.createURLWithParameters(params.standardPage(), params.selectedParameters());
        //   ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
        //   Navigator.of(context).pop();
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return RecommendParametersDialog(recommend);
        //     },
        //   );
        // } else {
        //   Navigator.of(context).pop();
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPage()));
        // }

        ref.read(searchingCategoryProvider.notifier).update((state) => category);
        Navigator.pop(context);
        context.pushNamed('partsList', pathParameters: {'id': custom.id!});
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        side: const BorderSide(
          color: Colors.green,
          width: 5,
        ),
      ),
      child: const Row(
        children: [
          Spacer(),
          Text(
            "パーツを選び直す",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
