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
      //height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total',
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
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < PartsCategory.values.length; i++)
                  if (custom.get(PartsCategory.values[i]) != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: _ratingBarColors[i],
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          _shortName(PartsCategory.values[i]),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${(parsePrice(custom.get(PartsCategory.values[i])!.price) / custom.calculateTotalPrice() * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
              ],
            ),
          )
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

  String _shortName(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return category.categoryName;
      case PartsCategory.cpuCooler:
        return 'CPUクーラー';
      case PartsCategory.memory:
        return 'メモリ';
      case PartsCategory.motherBoard:
        return 'マザボ';
      case PartsCategory.graphicsCard:
        return 'グラボ';
      case PartsCategory.ssd:
        return category.categoryName;
      case PartsCategory.pcCase:
        return category.categoryName;
      case PartsCategory.powerUnit:
        return '電源';
      case PartsCategory.caseFan:
        return category.categoryName;
    }
  }
}
