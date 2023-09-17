import 'package:custom_pc/nm_widgets/search_result_parts_list_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/parts_list_page/parameters_select_drawer.dart';
import '../../widgets/parts_list_page/parts_search_app_bar.dart';
import '../../widgets/parts_list_page/searching_parameter_widget.dart';

class PartsListPageNM extends StatelessWidget {
  const PartsListPageNM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PartsSearchAppBar(),
      endDrawer: ParametersSelectDrawer(),
      body: Column(
        children: [
          SearchingParameterWidget(),
          SearchResultPartsListWidgetNM(),
        ],
      ),
    );
  }
}
