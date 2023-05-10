import 'package:custom_pc/models/custom.dart';
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, right: 16),
          //   child: Divider(
          //     thickness: 1,
          //     color: _mainColor,
          //   ),
          // ),
          TotalPriceWidget(),
        ],
      ),
    );
  }
}
