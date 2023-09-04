import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/old/providers/create_custom.dart';
import 'package:custom_pc/old/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/size_config.dart';
import '../../pages/edit_custom_page.dart';
import '../../pages/parts_list_page.dart';
import '../../providers/pc_parts_list.dart';
import '../../providers/search_parameters.dart';
import '../edit_custom/add_parts_modal_widget.dart';

class NewCustomBottomBar extends ConsumerWidget {
  const NewCustomBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    const mainColor = Color.fromRGBO(60, 130, 80, 1);

    onTapGrit(PartsCategory category) {
      Navigator.of(context).pop();
      ref.read(createCustomNotifierProvider.notifier).reset();
      ref.read(createCustomNotifierProvider.notifier).updateCompatibilities();
      ref.read(searchingCategoryProviderOld.notifier).changeCategory(category);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditCustomPageOld(),
        ),
      );

      // カテゴリに合わせて検索URL、パラメータを設定する
      ref.read(pcPartsListNotifierProvider.notifier).switchCategory(category);
      ref.read(searchParameterProvider.notifier).replaceParameters(category);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PartsListPageOld()));
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return AddPartsModalWidget(onTapGrit);
          },
        );
      },
      child: Container(
        height: SizeConfig.blockSizeVertical * 8,
        decoration: const BoxDecoration(
          color: mainColor,
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'NEW CUSTOM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
