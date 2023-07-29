import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/tutorial_page.dart';
import 'package:custom_pc/widgets/stored_custom_list/new_custom_bottom_bar.dart';
import 'package:custom_pc/widgets/stored_custom_list/sort_icon_button.dart';
import 'package:custom_pc/widgets/stored_custom_list/stored_customs_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({super.key});

  void _showTutorial(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getBool('isAlreadyFirstLaunch') != true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlutterOverboardPage(),
          fullscreenDialog: true,
        ),
      );
      pref.setBool('isAlreadyFirstLaunch', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial(context));
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ライブラリ',
              style: TextStyle(
                fontSize: 24,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '保存済みカスタム',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
        leading: const SortIconButton(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return FlutterOverboardPage();
                },
              );
            },
            icon: const Icon(
              Icons.question_mark,
              color: mainColor,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: StoredCustomsListWidget(),
      ),
      bottomNavigationBar: const NewCustomBottomBar(),
    );
  }
}
