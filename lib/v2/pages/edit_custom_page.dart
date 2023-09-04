import 'package:custom_pc/v2/widgets/edit_custom_page/analyze_custom_widget.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/custom_title_edit_widget.dart';
import 'package:custom_pc/v2/widgets/edit_custom_page/edit_cancel_button.dart';
import 'package:flutter/material.dart';

import '../widgets/edit_custom_page/parts_edit_widget.dart';
import '../widgets/edit_custom_page/save_icon_button.dart';

class EditCustomPage extends StatelessWidget {
  const EditCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              'カスタムエディタ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            leading: const EditCancelButton(),
            actions: const [
              SaveIconButton(),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: '編集'),
                Tab(text: '分析'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                // 編集タブ
                ListView(
                  children: const [
                    CustomNameEditWidget(),
                    SizedBox(height: 16),
                    PartsEditWidget(),
                  ],
                ),
                // 分析タブ
                const AnalyzeCustomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
