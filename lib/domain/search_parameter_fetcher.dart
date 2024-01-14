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

class SearchParameterFetcher {
  static Future<Map<PartsCategory, CategorySearchParameter>> getAllParams() async {
    final Map<PartsCategory, CategorySearchParameter> paramMap = {};

    for (final category in PartsCategory.values) {
      switch (category) {
        case PartsCategory.cpu:
          paramMap[category] = await CpuSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.cpuCooler:
          paramMap[category] = await CpuCoolerSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.memory:
          paramMap[category] = await MemorySearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.motherboard:
          paramMap[category] = await MotherBoardSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.graphicsCard:
          paramMap[category] = await GraphicsCardSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.ssd:
          paramMap[category] = await SsdSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.powerUnit:
          paramMap[category] = await PowerUnitSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.pcCase:
          paramMap[category] = await PcCaseSearchParameterParser.fetchSearchParameter();
          break;
        case PartsCategory.caseFan:
          paramMap[category] = await CaseFanSearchParameterParser.fetchSearchParameter();
          break;
      }
    }

    return paramMap;
  }

  // 検索条件の選択、クリアの際に利用する
  static Map<PartsCategory, CategorySearchParameter> copyWith(
    Map<PartsCategory, CategorySearchParameter> state,
    PartsCategory category,
    CategorySearchParameter? params,
  ) {
    final newState = Map<PartsCategory, CategorySearchParameter>.from(state);

    if (params != null) {
      newState[category] = params;
    } else {
      for (final cate in PartsCategory.values) {
        newState[cate]!.clearSelectedParameter();
      }
    }
    return newState;
  }
}
