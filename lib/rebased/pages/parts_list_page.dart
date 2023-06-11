import 'package:custom_pc/domain/parts_detail_parser.dart';
import 'package:custom_pc/providers/pc_parts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/detail_parser.dart';

class PListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final partsList = ref.watch(pcPartsListNotifierProvider);
    return partsList.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Parts List'),
          ),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  // if (data[index].fullScaleImages == null) {
                    final detailParts = await PartsDetailParser.fetch(data[index]);
                    data[index] = detailParts;
                    ref.read(pcPartsListNotifierProvider.notifier).updateState(data);
                  // }
                },
                title: Text(data[index].title),
                subtitle: Text(data[index].price),
              );
            },
          ),
        );
      },
      loading: () {
        print('loading');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        print(error);
        print(stackTrace);
        return const Scaffold(
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
