import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';

class CustomCellWidget extends StatelessWidget {
  const CustomCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
              'https://www.d-rise.jp/images/item/p000000818179_1.jpg',
              width: SizeConfig.blockSizeHorizontal * 14,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                'https://www.d-rise.jp/images/item/p000000818179_1.jpg',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '¥0,000,000',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2023/06/23',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
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
