import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';

import '../../models/parts_shop.dart';

class ShopsWidget extends StatelessWidget {
  const ShopsWidget(this.shops, {super.key});

  final List<PartsShop> shops;
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView(
        children: [
          for (int i = 0; i < shops.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                height: 70,
                width: SizeConfig.blockSizeHorizontal * 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: mainColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      //width: SizeConfig.blockSizeHorizontal * 30,
                      child: Text(
                        shops[i].shopName,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      shops[i].price,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: mainColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
