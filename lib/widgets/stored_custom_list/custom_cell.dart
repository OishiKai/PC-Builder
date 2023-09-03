import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/custom.dart';

class CustomCellWidget extends ConsumerWidget {
  const CustomCellWidget(this.custom, {super.key});
  final Custom custom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, //色
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              custom.getMainPartsImage(),
              width: SizeConfig.blockSizeHorizontal * 14,
              height: SizeConfig.blockSizeHorizontal * 14,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                custom.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  custom.formatPrice(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  custom.date!,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
