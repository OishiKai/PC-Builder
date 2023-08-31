import 'package:custom_pc/v2/pages/dashboard.dart';
import 'package:custom_pc/v2/providers/custom_repository.dart';
import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/custom_title_edit_widget.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/edit_cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/edit_custom_page/parts_edit_widget.dart';

class EditCustomPageV2 extends ConsumerWidget {
  const EditCustomPageV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '編集',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'NotoSansJP',
            // fontWeight: FontWeight.bold,
          ),
        ),
        leading: const EditCancelButton(),
        actions: [
          IconButton(
            onPressed: () {
              // 編集中のカスタムを保存
              ref.read(customRepositoryNotifierProvider.notifier).updateCustom(custom);
              // bottomNavigationBarを表示
              ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: const [
            CustomNameEditWidget(),
            SizedBox(height: 16),
            PartsEditWidget(),
          ],
        ),
      ),
    );
  }
}
