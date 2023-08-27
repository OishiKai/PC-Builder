import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/edit_cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCustomPageV2 extends ConsumerWidget {
  const EditCustomPageV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'カスタムの編集',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'NotoSansJP',
            // fontWeight: FontWeight.bold,
          ),
        ),
        leading: EditCancelButton(
          // customのidがnullかどうかで新規作成か編集かを判断する
          isCreate: custom.id == null,
        ),
      ),
      body: const Center(
        child: Text('Edit Custom Page'),
      ),
    );
  }
}
