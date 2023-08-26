import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/parts_shop.dart';

class ShopsWidget extends StatelessWidget {
  const ShopsWidget(this.shops, {super.key});

  final List<PartsShop> shops;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      //height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          for (int i = 0; i < shops.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () async {
                  final url = Uri.parse(shops[i].shopPageUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not Launch $url';
                  }
                },
                child: Container(
                  height: 70,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 54,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.shopping_cart,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              child: Text(
                                shops[i].shopName,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        shops[i].price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
