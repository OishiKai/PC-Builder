import 'package:custom_pc/domain/parts_list_parser.dart';
import 'package:custom_pc/old/widgets/parts_list/parts_list_app_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_cooler_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/graphics_card_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/memory_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/mother_board_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/pc_case_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/power_unit_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/ssd_search_parameter_parser.dart';
import '../../models/pc_parts.dart';

part 'pc_parts_list.g.dart';

@Riverpod(keepAlive: true)
class PcPartsListNotifier extends _$PcPartsListNotifier {
  @override
  Future<List<PcParts>> build() {
    final standardPartsList = PartsListParser.fetch('');

    return standardPartsList;
  }

  // カテゴリ別の検索URLに変更する
  void switchCategory(PartsCategory category) async {
    state = const AsyncValue.loading();
    switch (category) {
      case PartsCategory.cpu:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(CpuSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.cpuCooler:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(CpuCoolerSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.memory:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(MemorySearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.motherboard:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(MotherBoardSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.graphicsCard:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(GraphicsCardSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.ssd:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(SsdSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.powerUnit:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(PowerUnitSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.pcCase:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(PcCaseSearchParameterParser.standardPage);
        });
        break;
      case PartsCategory.caseFan:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch(CaseFanSearchParameterParser.standardPage);
        });
        break;
      default:
        state = await AsyncValue.guard(() async {
          return PartsListParser.fetch('');
        });
        break;
    }
  }

  // 検索対象のURLを変更する
  Future<void> replaceSearchUrl(String listUrl) async {
    final text = ref.read(searchTextProviderOld);
    if (text != '' && listUrl.contains('?')) {
      // 検索条件が含まれる場合
      listUrl = '$listUrl&pdf_kw=$text';
    } else if (text != '') {
      // 検索条件が含まれない場合
      listUrl = '$listUrl?pdf_kw=$text';
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return PartsListParser.fetch(listUrl);
    });
  }

  // 詳細ページ情報を追加する
  void updateState(List<PcParts> partsList) {
    state = AsyncValue.data(partsList);
  }
}
