import 'package:custom_pc/domain/new_model/parts_detail_parser.dart';
import 'package:custom_pc/domain/new_model/parts_list_parser.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/providers/search_parameter.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/url_builder.dart';
import '../widgets/parts_list_page/parts_search_app_bar.dart';

part 'parts_list_nm.g.dart';

@Riverpod(keepAlive: true)
class PartsListNotifierNM extends _$PartsListNotifierNM {
  @override
  Future<List<PcParts>> build() {
    final searchingCategory = ref.watch(searchingCategoryProvider);
    final searchParameter = ref.watch(searchParameterNotifierProvider);
    final searchText = ref.watch(searchTextProvider);

    final selectedParams = searchParameter![searchingCategory]!.selectedParameters();
    final url = UrlBuilder.createURLWithParameters(
      searchingCategory.basePartsListUrl(),
      selectedParams,
    );

    if (searchText == '') return PartsListParserNM.fetch(url);
    if (selectedParams.isNotEmpty) {
      return PartsListParserNM.fetch('$url&pdf_kw=$searchText');
    } else {
      return PartsListParserNM.fetch('$url?pdf_kw=$searchText');
    }
  }

  Future<void> updateDetailPartsInfo(int index, PcParts parts) async {
    if (parts.fullScaleImageCount != null) return;
    final updatedParts = await PartsDetailParserNM.fetch(parts);

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
