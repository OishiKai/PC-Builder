import 'package:custom_pc/models/custom.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';

class PartsCompatibilityWidget extends ConsumerWidget {
  PartsCompatibilityWidget({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final custom = ref.watch(customProvider);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CPU と マザーボード
          if (custom.get(PartsCategory.cpu) != null && custom.get(PartsCategory.motherBoard) != null)
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: SizeConfig.blockSizeHorizontal * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CPU',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Image.network(
                          custom.get(PartsCategory.cpu)!.image,
                          width: SizeConfig.blockSizeHorizontal * 14,
                          //height: SizeConfig.blockSizeHorizontal * 14,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.multiple_stop_outlined,
                      size: 20,
                      color: _mainColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'マザボ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Image.network(
                          custom.get(PartsCategory.motherBoard)!.image,
                          width: SizeConfig.blockSizeHorizontal * 14,
                          //height: SizeConfig.blockSizeHorizontal * 14,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: _mainColor,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(
                              'ソケット形状一致',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _mainColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.error_rounded,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(
                              'チップセット非対応',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.help,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(
                              'チップセット対応判定不可',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
