import 'package:custom_pc/providers/custom_repository.dart';
import 'package:custom_pc/widgets/custom_detail_page/parts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/edit_custom.dart';
import '../widgets/custom_detail_page/custom_summary_widget.dart';
import '../widgets/custom_detail_page/delete_custom_dialog.dart';
import 'dashboard.dart';

class CustomDetailPage extends ConsumerWidget {
  const CustomDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(customRepositoryNotifierProvider);
    return custom.when(
      data: (data) {
        // idに一致するカスタムが存在するか確認(カスタム削除時にNoElementErrorとなるため)
        if (data.where((element) => element.id == id).isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final custom = data.firstWhere((element) => element.id == id);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              custom.name!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteCustomDialog(custom: custom);
                    },
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 32,
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'SUMMARY',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      custom.formatPrice(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomSummaryWidget(custom: custom),
              PartsListWidget(custom: custom),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // 表示中のカスタムを編集用Providerにセット
              ref.read(editCustomNotifierProvider.notifier).setCustom(custom);
              // bottomNavigationBarを非表示化
              ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => false);
              context.goNamed('edit', pathParameters: {'id': id});
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(
              Icons.edit,
              size: 32,
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (e, s) {
        return const Center(
          child: Text('読み込みに失敗しました'),
        );
      },
    );
  }
}
