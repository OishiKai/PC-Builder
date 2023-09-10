import 'package:custom_pc/models/detail_page_usage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/custom_old.dart';
import '../../../models/pc_parts.dart';

class PartsListWidget extends StatelessWidget {
  const PartsListWidget({super.key, required this.custom});
  final CustomOld custom;

  @override
  Widget build(BuildContext context) {
    // {カテゴリー: PcParts}のMapをListに変換
    final partsList = custom.align().entries.map((e) => _PartsAndCategory(e.key, e.value)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // カテゴリーごとに分けたパーツを表示
          for (final p in partsList)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // カテゴリ名部分
                Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      p.category.categoryName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // パーツ情報部分
                InkWell(
                  onTap: () {
                    // パーツ詳細ページ(閲覧モード)に遷移
                    context.push(
                      '/home/parts/${DetailPageUsage.view.value}/${custom.id}/${p.category.categoryName}',
                    );
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p.parts.image,
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.parts.maker,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              p.parts.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              p.parts.price,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class _PartsAndCategory {
  _PartsAndCategory(this.category, this.parts);
  final PartsCategory category;
  final PcPartsOld parts;
}
