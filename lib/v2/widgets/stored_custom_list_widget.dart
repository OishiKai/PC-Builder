import 'package:custom_pc/providers/stored_customs.dart';
import 'package:custom_pc/v2/widgets/stored_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom.dart';

class StoredCustomListWidget extends ConsumerWidget {
  const StoredCustomListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedCustoms = ref.watch(storedCustomsNotifierProvider);

    return storedCustoms.when(data: (data) {
      final customList = [];
      data.forEach((key, value) => customList.add(_StoredCustom(id: key, custom: value)));

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
                onTap: () => debugPrint('tapped'),
                child: StoredCustomCard(
                  custom: customList[index].custom,
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

// MapをListにする用のクラス
class _StoredCustom {
  _StoredCustom({
    required this.id,
    required this.custom,
  });

  final String id;
  final Custom custom;
}
