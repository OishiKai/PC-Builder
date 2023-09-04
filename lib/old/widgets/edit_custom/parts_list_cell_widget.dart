import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/old/pages/parts_detail_page.dart';
import 'package:custom_pc/old/providers/searching_category.dart';
import 'package:custom_pc/v2/providers/detail_page_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartsListCellWidget extends ConsumerWidget {
  const PartsListCellWidget(this.category, this.parts, {super.key});
  final PartsCategory category;
  final PcParts parts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(14, 31, 18, 1);
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        // 詳細画面を編集モードで開く
        ref.read(detailPageUsageNotifierProvider.notifier).switchEdit();
        // 詳細画面から他のパーツを選択する際、カテゴリーを利用するためここでセット
        ref.read(searchingCategoryProviderOld.notifier).changeCategory(category);
        Navigator.push(context, MaterialPageRoute(builder: (context) => PartsDetailPageOld(parts)));
      },
      child: Padding(
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
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: mainColor,
              ),
            ],
          ),
          Container(
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
                        color: Color.fromRGBO(80, 99, 82, 1),
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
                          color: Color.fromRGBO(9, 109, 54, 1),
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
        ]),
      ),
    );
  }
}
