import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/edit_custom.dart';
import '../../../providers/parts_list.dart';
import '../../models/detail_page_usage.dart';
import '../parts_detail/star_widget.dart';

class SearchResultPartsListWidget extends ConsumerWidget {
  const SearchResultPartsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPartsList = ref.watch(partsListProvider);

    void showProgressDialog() {
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
        },
      );
    }

    return asyncPartsList.when(
      data: (data) {
        return Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final parts = data[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      // プログレスサークル表示
                      showProgressDialog();

                      // パーツ詳細情報を取得
                      await ref.read(partsListProvider.notifier).updateDetailPartsInfo(index, parts);
                      final custom = ref.read(editCustomNotifierProvider);
                      if (!context.mounted) return;

                      // プログレスサークル非表示
                      context.pop();
                      // パーツ詳細ページへ遷移
                      if (custom.id == null) {
                        // 新規作成の場合
                        context.pushNamed(
                          'create_partsDetail_searching',
                          pathParameters: {
                            'usage': DetailPageUsage.create.value,
                            'listIndex': index.toString(),
                          },
                        );
                      } else {
                        // 編集の場合
                        context.pushNamed(
                          'partsDetailForCreate',
                          pathParameters: {
                            'id': custom.id!,
                            'usage': DetailPageUsage.create.value,
                            'listIndex': index.toString(),
                          },
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              parts.image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.contain,
                              errorBuilder: (context, object, stackTrace) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: Colors.grey[300],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      parts.maker,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                    Visibility(
                                      visible: parts.isNew,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Theme.of(context).colorScheme.errorContainer,
                                        ),
                                        child: Text(
                                          'NEW',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onErrorContainer,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  parts.title,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    StarWidget(parts.star),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        parts.evaluation ?? '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  parts.price,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text('エラーが発生しました'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
