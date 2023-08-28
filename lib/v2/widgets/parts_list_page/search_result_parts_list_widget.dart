import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/parts_list.dart';

class SearchResultPartsListWidget extends ConsumerWidget {
  const SearchResultPartsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPartsList = ref.watch(partsListProvider);

    return asyncPartsList.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final parts = data[index];
            return ListTile(
              title: Text(parts.title),
              subtitle: Text(parts.price.toString()),
            );
          },
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
