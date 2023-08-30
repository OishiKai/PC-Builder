import 'package:custom_pc/v2/widgets/parts_list_page/search_result_parts_list_widget.dart';
import 'package:custom_pc/v2/widgets/parts_list_page/searching_parameter_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/parts_list_page/PartsSearchAppBar.dart';
import '../widgets/parts_list_page/parameters_select_drawer.dart';

class PartsListPageV2 extends StatelessWidget {
  const PartsListPageV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PartsSearchAppBar(),
      endDrawer: ParametersSelectDrawer(),
      body: const Column(
        children: [
          // AddParametersWidget(),
          SearchingParameterWidgetV2(),
          SearchResultPartsListWidget(),
        ],
      ),
    );
  }
}
