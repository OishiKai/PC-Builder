import 'package:custom_pc/widgets/parts_list/parts_list_app_bar.dart';
import 'package:custom_pc/widgets/parts_list/parts_list_cell.dart';
import 'package:custom_pc/widgets/parts_list/search_parameter_modal.dart';
import 'package:flutter/material.dart';

import '../config/size_config.dart';

class PartsListPage extends StatelessWidget {
  const PartsListPage({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  //final PartsCategory category;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PartsListAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 16),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return const SearchParameterModal();
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                primary: _mainColor,
              ),
              child: Row(
                children: const [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '絞り込み',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const PartsListWidget(),
        ],
      ),
    );
  }
}
