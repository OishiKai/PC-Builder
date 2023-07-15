import 'package:custom_pc/widgets/create_custom/total_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../providers/create_custom.dart';
import '../create_custom/parts_compatibility_widget.dart';

class CustomSummaryPanelWidget extends ConsumerWidget {
  const CustomSummaryPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);
    final comps = custom.compatibilities;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 2.5,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_up_sharp,
              color: Color.fromRGBO(60, 130, 80, 1),
              size: 30,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 42.5,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 13,
                width: SizeConfig.blockSizeHorizontal * 15,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
                  ),
                  onPressed: () {
                    // ref.read(createCustomNotifierProvider.notifier).reset();
                    // Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 42.5,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    custom.formatPrice(),
                    style: const TextStyle(
                      color: Color.fromRGBO(9, 109, 54, 1),
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 43,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: const TabBar(
                  indicatorColor: Color.fromRGBO(60, 130, 80, 1),
                  labelColor: Color.fromRGBO(60, 130, 80, 1),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                        child: Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                    Tab(
                        child: Text(
                      'Compatibility',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ],
                ),
                body: Container(
                  height: SizeConfig.blockSizeVertical * 37,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEDECF2),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(45),
                        bottomLeft: Radius.circular(45),
                      )),
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Container(alignment: Alignment.topCenter, child: TotalPriceWidget()),
                      ),
                      if (comps!.isNotEmpty)
                        ListView(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            for (int i = 0; i < comps!.length; i++) PartsCompatibilityWidget(comps[i]),
                          ],
                        ),
                      if (comps.isEmpty)
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No compatibility',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
          //   child: Container(
          //     height: SizeConfig.blockSizeVertical * 37,
          //     decoration: BoxDecoration(
          //       color: const Color(0xFFEDECF2),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: ListView(
          //       children: [
          //         SizedBox(
          //           height: 10,
          //         ),
          //         if (ref.watch(createCustomNotifierProvider).compatibilities != null)
          //           for (int i = 0; i < ref.watch(createCustomNotifierProvider).compatibilities!.length; i++) PartsCompatibilityWidget(ref.watch(createCustomNotifierProvider).compatibilities![i]),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
