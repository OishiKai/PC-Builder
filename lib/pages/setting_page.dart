import 'package:flutter/material.dart';

import '../widgets/theme_setting_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        centerTitle: true,
        title: const Text('設定'),
      ),
      body: const Column(
        children: [ThemeSettingWidget()],
      ),
    );
  }
}
