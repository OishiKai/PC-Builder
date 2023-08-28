import 'package:custom_pc/v2/widgets/parts_list_page/search_result_parts_list_widget.dart';
import 'package:custom_pc/v2/widgets/parts_list_page/searching_parameter_widget.dart';
import 'package:flutter/material.dart';

class PartsListPageV2 extends StatelessWidget {
  const PartsListPageV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'パーツ検索',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'パーツを検索してカスタムを作成',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SearchingParameterWidgetV2(),
          const SearchResultPartsListWidget(),
        ],
      ),
    );
  }
}
