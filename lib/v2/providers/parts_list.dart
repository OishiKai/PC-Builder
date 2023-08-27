import 'package:custom_pc/v2/providers/search_parameters.dart';
import 'package:custom_pc/v2/providers/searching_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/parts_list_parser.dart';
import '../../domain/url_builder.dart';
import '../../models/pc_parts.dart';

part 'parts_list.g.dart';

@Riverpod(keepAlive: true)
class PartsList extends _$PartsList {
  @override
  Future<List<PcParts>> build() {
    final searchingCategory = ref.watch(searchingCategoryProviderV2);
    final searchParameter = ref.watch(searchParametersNotifierProvider);

    return searchParameter.when(
      data: (data) {
        final selectedParams = data.selectedParameters();
        final url = UrlBuilder.createURLWithParameters(
          searchingCategory.basePartsListUrl(),
          selectedParams,
        );
        return PartsListParser.fetch(url);
        // return Future.value([]);
      },
      loading: () {
        return Future.value([]);
      },
      error: (error, stackTrace) {
        return Future.value([]);
      },
    );
  }
}
