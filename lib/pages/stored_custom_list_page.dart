import 'package:flutter/material.dart';

import '../config/share_preferences_instance.dart';
import '../tutorial_page.dart';
import '../widgets/sort_icon_button.dart';
import '../widgets/stored_custom_list_page/create_custom_floating_action_button.dart';
import '../widgets/stored_custom_list_page/stored_custom_list_widget.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({super.key});

  void _showTutorial(BuildContext context) {
    final prefs = SharedPreferencesInstance().prefs;

    if (prefs.getBool('isAlreadyFirstLaunch') != true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorialPage(),
          fullscreenDialog: true,
        ),
      );
      prefs.setBool('isAlreadyFirstLaunch', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ライブラリ',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '保存済みカスタム',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        leading: SortIconButton(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TutorialPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: Icon(
              Icons.help_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
          ),
        ],
      ),
      body: const StoredCustomListWidget(),
      floatingActionButton: const CreateCustomFloatingActionButton(),
    );
  }
}
