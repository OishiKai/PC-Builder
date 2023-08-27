import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/custom_title_edit_widget.dart';
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
        leading: const EditCancelButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            CustomNameEditWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {},
        child: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
