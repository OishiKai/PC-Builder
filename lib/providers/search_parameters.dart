import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import '../domain/search_parameter_parser/cpu_cooler_search_parameter_parser.dart';
import '../domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';
import '../domain/search_parameter_parser/graphics_card_search_parameter_parser.dart';
import '../domain/search_parameter_parser/memory_search_parameter_parser.dart';
import '../domain/search_parameter_parser/mother_board_search_parameter_parser.dart';
import '../domain/search_parameter_parser/pc_case_search_parameter_parser.dart';
import '../domain/search_parameter_parser/power_unit_search_parameter_parser.dart';
import '../domain/search_parameter_parser/ssd_search_parameter_parser.dart';
import '../models/category_search_parameter.dart';
import '../models/parts_category.dart';
import '../providers/searching_category.dart';

part 'gen/search_parameters.g.dart';

@Riverpod(keepAlive: true)
class SearchParametersNotifier extends _$SearchParametersNotifier {
  @override
  Future<CategorySearchParameter> build() {
    // searchingCategoryProviderを監視して、カテゴリが変更されたら検索条件情報を更新する
    final category = ref.watch(searchingCategoryProvider);
    return _fetchParameters(category);
  }

  Future<CategorySearchParameter> _fetchParameters(PartsCategory category) async {
    switch (category) {
      case PartsCategory.cpu:
        return CpuSearchParameterParser.fetchSearchParameter();
      case PartsCategory.cpuCooler:
        return CpuCoolerSearchParameterParser.fetchSearchParameter();
      case PartsCategory.memory:
        return MemorySearchParameterParser.fetchSearchParameter();
      case PartsCategory.motherboard:
        return MotherBoardSearchParameterParser.fetchSearchParameter();
      case PartsCategory.graphicsCard:
        return GraphicsCardSearchParameterParser.fetchSearchParameter();
      case PartsCategory.ssd:
        return SsdSearchParameterParser.fetchSearchParameter();
      case PartsCategory.powerUnit:
        return PowerUnitSearchParameterParser.fetchSearchParameter();
      case PartsCategory.pcCase:
        return PcCaseSearchParameterParser.fetchSearchParameter();
      case PartsCategory.caseFan:
        return CaseFanSearchParameterParser.fetchSearchParameter();
    }
  }

  // 検索条件を追加する
  void toggleParameterSelect(String paramName, int index) {
    state.when(
      data: (data) {
        state = AsyncValue.data(data.toggleParameterSelect(paramName, index));
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }

  // 検索条件をクリア
  void clearSelectedParameter() {
    state.when(
      data: (data) {
        state = AsyncValue.data(data.clearSelectedParameter());
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }
}
