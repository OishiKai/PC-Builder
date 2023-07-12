import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';

class CustomSummaryPanelWidget extends ConsumerWidget {
  const CustomSummaryPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 3,
            alignment: Alignment.topCenter,
            child: const Icon(
              Icons.menu,
              color: const Color.fromRGBO(9, 109, 54, 1),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
            child: Container(
              height: SizeConfig.blockSizeVertical * 10,
              width: double.infinity,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                //color: const Color.fromRGBO(157, 246, 176, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '¥0,000,000',
                style: TextStyle(
                  color: const Color.fromRGBO(9, 109, 54, 1),
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
