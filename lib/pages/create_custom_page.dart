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
      backgroundColor: _mainColor,
      //backgroundColor: const Color(0xFFEDECF2),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification notification) {
          notification.disallowGlow();
          return false;
        },
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.blockSizeVertical * 90,
                ),
                child: Container(
                  //height: SizeConfig.blockSizeVertical * 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDECF2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                ref.read(customProviderOld.notifier).reset();
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

                      if (ref.watch(customProviderOld).compatibilities != null)
                        for (int i = 0; i < ref.watch(customProviderOld).compatibilities!.length; i++) PartsCompatibilityWidget(ref.watch(customProviderOld).compatibilities![i]),

                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
