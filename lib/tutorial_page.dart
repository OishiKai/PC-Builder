import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class FlutterOverboardPage extends StatelessWidget {
  FlutterOverboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.pop(context);
        },
        finishCallback: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  final pages = [
    PageModel(color: const Color(0xFF95cedd), imageAssetPath: 'images/tutorial01.png', title: 'カスタムを作成', body: '画面下部から開始できます', doAnimateImage: false),
    PageModel(color: const Color(0xFF9B90BC), imageAssetPath: 'images/tutorial02.png', title: 'パーツを選択', body: 'キーワード、条件で検索できます', doAnimateImage: true),
    PageModel(color: const Color(0xFF2B90AC), imageAssetPath: 'images/tutorial03.png', title: 'カスタムの管理', body: '合計金額、パーツ間の互換性を確認できます', doAnimateImage: true),
    PageModel(color: const Color(0xFFFB90AC), imageAssetPath: 'images/tutorial04.png', title: 'カスタムの確認', body: '保存したカスタムを確認・編集できます', doAnimateImage: true),
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
