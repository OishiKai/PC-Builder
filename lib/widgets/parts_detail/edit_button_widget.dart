import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/parts_list_page.dart';
import '../../providers/pc_parts_list.dart';
import '../../providers/search_parameters.dart';
import '../../providers/searching_category.dart';

class EditButtonWidget extends ConsumerWidget {
  const EditButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.read(searchingCategoryProvider);
    return ElevatedButton(
      onPressed: () {
        // カテゴリに合わせて検索URL、パラメータを設定する
        ref.read(pcPartsListNotifierProvider.notifier).switchCategory(category);
        ref.read(searchParameterProvider.notifier).replaceParameters(category);

        // 一旦編集画面に戻ってからパーツ一覧画面に遷移する
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PartsListPage()));
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
      child: Row(
        children: const [
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
