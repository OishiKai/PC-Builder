import 'package:custom_pc/v2/providers/search_parameters.dart';
import 'package:custom_pc/v2/providers/searching_category.dart';
import 'package:custom_pc/v2/widgets/parts_list_page/parts_search_app_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/parts_detail_parser.dart';
import '../../domain/parts_list_parser.dart';
import '../../domain/url_builder.dart';
import '../../models/pc_parts.dart';

part 'gen/parts_list.g.dart';

@Riverpod(keepAlive: true)
class PartsList extends _$PartsList {
  @override
  Future<List<PcParts>> build() {
    final searchingCategory = ref.watch(searchingCategoryProviderV2);
    final searchParameter = ref.watch(searchParametersNotifierProvider);
    final searchText = ref.watch(searchTextProviderV2);

    return searchParameter.when(
      data: (data) {
        final selectedParams = data.selectedParameters();
        final url = UrlBuilder.createURLWithParameters(
          searchingCategory.basePartsListUrl(),
          selectedParams,
        );

        if (searchText == '') return PartsListParser.fetch(url);

        if (selectedParams.isNotEmpty) {
          return PartsListParser.fetch('$url&pdf_kw=$searchText');
        } else {
          return PartsListParser.fetch('$url?pdf_kw=$searchText');
        }
      },
      loading: () {
        return Future.value([]);
      },
      error: (error, stackTrace) {
        return Future.value([]);
      },
    );
  }

  Future<void> updateDetailPartsInfo(int index, PcParts parts) async {
    if (parts.fullScaleImages != null) return;
    final updatedParts = await PartsDetailParser.fetch(parts);

    state.when(
      data: (data) async {
        data[index] = updatedParts;
        state = AsyncValue.data(data);
      },
      error: (e, t) {},
      loading: () {},
    );
  }
}
