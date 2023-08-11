import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/models/recommend_parameter.dart';

import '../models/custom.dart';

class ParameterRecommender {
  late final Custom custom;
  late final PartsCategory selectingCategory;
  late final CategorySearchParameter params;

  List<RecommendParameter> recommendedParameters = [];

  ParameterRecommender(this.custom, this.selectingCategory, this.params) {
    recommendedParameters = recommend();
  }

  List<RecommendParameter> recommend() {
    List<RecommendParameter> recommendedParameter = [];

    switch (selectingCategory) {
      case PartsCategory.cpu:
        recommendedParameter = recommendParamsForCpu();
        break;
      case PartsCategory.cpuCooler:
        // TODO: Handle this case.
        break;
      case PartsCategory.memory:
        // TODO: Handle this case.
        break;
      case PartsCategory.motherBoard:
        // TODO: Handle this case.
        break;
      case PartsCategory.graphicsCard:
        // TODO: Handle this case.
        break;
      case PartsCategory.ssd:
        // TODO: Handle this case.
        break;
      case PartsCategory.pcCase:
        // TODO: Handle this case.
        break;
      case PartsCategory.powerUnit:
        // TODO: Handle this case.
        break;
      case PartsCategory.caseFan:
        // TODO: Handle this case.
        break;
    }
    return recommendedParameter;
  }

  String? _extractSpec(Map<String, String?> specs, String param) {
    String? specInfo;
    specs.forEach((key, value) {
      if (key.contains(param)) {
        specInfo = value;
      }
    });
    return specInfo;
  }

  List<RecommendParameter> recommendParamsForCpu() {
    if (custom.motherBoard == null) {
      return [];
    }

    // マザーボードのソケット形状を取得
    final motherBoard = custom.motherBoard!;
    final rawSocket = _extractSpec(motherBoard.specs!, 'CPUソケット');
    if (rawSocket == null) {
      return [];
    }

    final socket = rawSocket.replaceAll('Socket', '');

    // CPUのパラメータに選択中のマザーボードのソケット形状があるか確認
    // ある場合は、そのソケット形状のインデックスを返す
    int paramIndex = 0;
    int specIndex = 0;
    bool isComplete = false;
    final p = params.alignParameters();
    for (var para in p) {
      for (var par in para.entries) {
        specIndex = 0;
        if (par.key.contains('ソケット\n形状')) {
          for (var element in par.value) {
            if (element.name.contains(socket)) {
              isComplete = true;
              break;
            }
            specIndex++;
          }
        }
        if (isComplete) {
          break;
        }
      }
      if (isComplete) {
        break;
      }
    }

    if (isComplete) {
      return [
        // "ソケット形状"は3番目のパラメータなので、3を指定
        RecommendParameter(PartsCategory.motherBoard, 3, socket, specIndex),
      ];
    }

    return [];
  }
}
