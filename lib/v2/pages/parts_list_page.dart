import 'package:custom_pc/v2/widgets/parts_list_page/search_result_parts_list_widget.dart';
import 'package:custom_pc/v2/widgets/parts_list_page/searching_parameter_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/parts_list_page/parameters_select_drawer.dart';
import '../widgets/parts_list_page/parts_search_app_bar.dart';

class PartsListPage extends StatelessWidget {
  const PartsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PartsSearchAppBar(),
      endDrawer: ParametersSelectDrawer(),
      body: Column(
        children: [
          SearchingParameterWidget(),
          SearchResultPartsListWidget(),
        ],
      ),
    );
  }
}
