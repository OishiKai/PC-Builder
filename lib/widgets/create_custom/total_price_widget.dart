import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/models/custom.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalPriceWidget extends ConsumerWidget {
  TotalPriceWidget({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final _ratingBarColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(customProvider);
    return Container(
      width: SizeConfig.blockSizeHorizontal * 92,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '総計',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _mainColor,
                  ),
                ),
                const Spacer(),
                Text(
                  formatPrice(custom.calculateTotalPrice()),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _mainColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: SizeConfig.blockSizeHorizontal * 4),
              child: Row(
                children: [
                  for (int i = 0; i < PartsCategory.values.length; i++)
                    if (custom.get(PartsCategory.values[i]) != null)
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 84 * (parsePrice(custom.get(PartsCategory.values[i])!.price) / custom.calculateTotalPrice()),
                        height: 5,
                        decoration: BoxDecoration(
                          color: _ratingBarColors[i],
                        ),
                      )
                ],
              )),
        ],
      ),
    );
  }

  String formatPrice(int value) {
    final String stringValue = value.toString();
    final StringBuffer buffer = StringBuffer();

    buffer.write('¥');

    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }

    return buffer.toString();
  }

  int parsePrice(String price) {
    final normalizedPrice = price.replaceAll('¥', '').replaceAll(',', '');
    return int.parse(normalizedPrice);
  }
}
