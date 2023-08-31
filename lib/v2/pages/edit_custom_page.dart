import 'package:custom_pc/v2/widgets/edit_custom_page/custom_title_edit_widget.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/edit_cancel_button.dart';
import 'package:flutter/material.dart';

import '../widgets/edit_custom_page/parts_edit_widget.dart';
import '../widgets/edit_custom_page/save_icon_button.dart';

class EditCustomPageV2 extends StatelessWidget {
  const EditCustomPageV2({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          SaveIconButton(),
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
