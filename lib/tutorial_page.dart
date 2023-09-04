import 'package:custom_pc/v2/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TutorialPage extends ConsumerWidget {
  TutorialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // 初回のチュートリアル表示後はナビゲーションバーを表示する
          ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
          Navigator.pop(context);
        },
        finishCallback: () {
          ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => true);
          Navigator.pop(context);
        },
      ),
    );
  }

  final pages = [
    PageModel(color: const Color(0xFF95cedd), imageAssetPath: 'images/tutorial_v2_01.jpg', title: 'カスタムを作成', body: '画面下部から開始できます', doAnimateImage: false),
    PageModel(color: const Color(0xFF9B90BC), imageAssetPath: 'images/tutorial_v2_02.jpg', title: 'パーツを選択', body: 'キーワード、条件で検索できます', doAnimateImage: true),
    PageModel(color: const Color(0xFF2B90AC), imageAssetPath: 'images/tutorial_v2_03.jpg', title: 'カスタムの管理', body: '合計金額、パーツ間の互換性を確認できます', doAnimateImage: true),
    PageModel(color: const Color(0xFFFB90AC), imageAssetPath: 'images/tutorial_v2_04.jpg', title: 'カスタムの確認', body: '保存したカスタムを確認・編集できます', doAnimateImage: true),
    PageModel.withChild(
        child: const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めましょう",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            )),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];
}
