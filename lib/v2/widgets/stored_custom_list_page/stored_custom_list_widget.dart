import 'package:custom_pc/providers/custom_repository.dart';
import 'package:custom_pc/v2/widgets/stored_custom_list_page/stored_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 保存済みカスタム一覧表示Widget
class StoredCustomListWidget extends ConsumerWidget {
  const StoredCustomListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedCustoms = ref.watch(customRepositoryNotifierProvider);

    return storedCustoms.when(data: (data) {
      if (data.isEmpty) {
        return const Center(
          child: Text('保存済みのカスタムはありません'),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ListView.builder(
            // 保存済みカスタムの最後に余白を作るために+1
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              if (index == data.length) {
                return const SizedBox(
                  height: 80,
                );
              }
              return InkWell(
                onTap: () {
                  // 詳細画面(CustomDetailPage)へ遷移
                  context.push('/home/detail/${data[index].id}');
                },
                child: StoredCustomCard(
                  custom: data[index],
                ),
              );
            },
          ),
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (e, s) {
      return const Center(
        child: Text('読み込みに失敗しました'),
      );
    });
  }
}
