import 'package:custom_pc/v2/widgets/stored_custom_list_widget.dart';
import 'package:flutter/material.dart';

class StoredCustomListPageV2 extends StatelessWidget {
  const StoredCustomListPageV2({super.key});

  @override
  Widget build(BuildContext context) {
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
          leading: IconButton(
            onPressed: () {
              debugPrint('on pressed sort icon button');
            },
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                debugPrint('on pressed question mark icon button');
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('on pressed add icon button');
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '検索',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'ライブラリ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '設定',
            ),
          ],
        ));
  }
}
