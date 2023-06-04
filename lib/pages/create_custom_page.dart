import 'package:custom_pc/models/custom.dart';
import 'package:custom_pc/widgets/create_custom/parts_compatibility_widget.dart';
import 'package:custom_pc/widgets/create_custom/parts_scroll_widget.dart';
import 'package:custom_pc/widgets/create_custom/total_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';

class CreateCustomPage extends ConsumerWidget {
  const CreateCustomPage({Key? key}) : super(key: key);

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(customProvider.notifier).reset();
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: _mainColor,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'NEW CUSTOM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _mainColor,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const PartsScrollWidget(),
          const SizedBox(
            height: 16,
          ),

          // 合計金額・割合ウィジェット
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: TotalPriceWidget(),
          ),

          const SizedBox(
            height: 16,
          ),

          if (ref.watch(customProvider).compatibilities != null)
            NotificationListener(
              onNotification: (OverscrollIndicatorNotification notification) {
                notification.disallowGlow();
                return false;
              },
              child: Container(
                height: 290,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  child: Column(
                    children: [
                      for (int i = 0; i < ref.watch(customProvider).compatibilities!.length; i++) PartsCompatibilityWidget(ref.watch(customProvider).compatibilities![i]),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
