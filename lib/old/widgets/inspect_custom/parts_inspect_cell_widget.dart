import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../v2/providers/detail_page_usage.dart';
import '../../pages/parts_detail_page.dart';

class PartsInspectCellWidget extends ConsumerWidget {
  const PartsInspectCellWidget(this.category, this.parts, {super.key});
  final PartsCategory category;
  final PcParts parts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 4,
            ),
            Text(
              category.categoryName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: mainColor,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            ref.read(detailPageUsageNotifierProvider.notifier).switchView();
            Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPageOld(parts)));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
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
              children: [
                const SizedBox(
                  width: 8,
                ),
                Image.network(
                  parts.image,
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeHorizontal * 20,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parts.maker,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Text(
                        parts.title,
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
                      height: 8,
                    ),
                    Text(
                      parts.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: mainColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
