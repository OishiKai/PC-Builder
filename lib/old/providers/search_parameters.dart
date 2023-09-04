import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_search_parameter.dart';
import '../../domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_cooler_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/graphics_card_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/memory_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/mother_board_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/pc_case_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/power_unit_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/ssd_search_parameter_parser.dart';

class CategorySearchParameterNotifier extends StateNotifier<CategorySearchParameter?> {
  CategorySearchParameterNotifier(super.state);

  // 検索条件を追加する
  void toggleParameterSelect(String paramName, int index) {
    if (state == null) return;
    state = state!.toggleParameterSelect(paramName, index);
  }

  // 検索条件をクリア
  void clearSelectedParameter() {
    if (state == null) return;
    state = state!.clearSelectedParameter();
  }

  // 別のカテゴリの検索条件に切り替える
  Future<void> replaceParameters(PartsCategory category) async {
    switch (category) {
      case PartsCategory.cpu:
        state = await CpuSearchParameterParser.fetchSearchParameter();
        break;
      case PartsCategory.cpuCooler:
        state = await CpuCoolerSearchParameterParser.fetchSearchParameter();
        break;
      case PartsCategory.memory:
        state = await MemorySearchParameterParser.fetchSearchParameter();
        break;
      case PartsCategory.motherboard:
        state = (await MotherBoardSearchParameterParser.fetchSearchParameter())!;
        break;
      case PartsCategory.graphicsCard:
        state = (await GraphicsCardSearchParameterParser.fetchSearchParameter())!;
        break;
      case PartsCategory.ssd:
        state = await SsdSearchParameterParser.fetchSearchParameter();
        break;
      case PartsCategory.powerUnit:
        state = (await PowerUnitSearchParameterParser.fetchSearchParameter())!;
        break;
      case PartsCategory.pcCase:
        state = await PcCaseSearchParameterParser.fetchSearchParameter();
        break;
      case PartsCategory.caseFan:
        state = await CaseFanSearchParameterParser.fetchSearchParameter();
        break;
    }
  }
}

final searchParameterProvider = StateNotifierProvider<CategorySearchParameterNotifier, CategorySearchParameter?>((ref) {
  return CategorySearchParameterNotifier(null);
});
