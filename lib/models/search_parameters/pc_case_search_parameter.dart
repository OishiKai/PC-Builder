import 'package:custom_pc/domain/search_parameter_parser/pc_case_search_parameter_parser.dart';
import 'package:custom_pc/models/category_search_parameter.dart';

class PcCaseSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> supportMotherBoards;
  final List<PartsSearchParameter> supportGraphicsCards;
  final List<PartsSearchParameter> colors;

  PcCaseSearchParameter(this.supportMotherBoards, this.supportGraphicsCards, this.colors);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'対応マザーボード': supportMotherBoards},
      {'対応グラフィックボード': supportGraphicsCards},
      {'カラー': colors},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearSupportMotherBoards = [];
    for (var element in supportMotherBoards) {
      element.isSelect = false;
      clearSupportMotherBoards.add(element);
    }
    final List<PartsSearchParameter> clearSupportGraphicsCards = [];
    for (var element in supportGraphicsCards) {
      element.isSelect = false;
      clearSupportGraphicsCards.add(element);
    }
    final List<PartsSearchParameter> clearColors = [];
    for (var element in colors) {
      element.isSelect = false;
      clearColors.add(element);
    }

    return PcCaseSearchParameter(clearSupportMotherBoards, clearSupportGraphicsCards, clearColors);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in supportMotherBoards) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in supportGraphicsCards) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in colors) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in supportMotherBoards) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in supportGraphicsCards) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in colors) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return PcCaseSearchParameterParser.standardPage;
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case '対応マザーボード':
        var toggleSupportMotherBoards = supportMotherBoards;
        toggleSupportMotherBoards[index].isSelect = !toggleSupportMotherBoards[index].isSelect;
        return PcCaseSearchParameter(toggleSupportMotherBoards, supportGraphicsCards, colors);
      case '対応グラフィックボード':
        var toggleSupportGraphicsCards = supportGraphicsCards;
        toggleSupportGraphicsCards[index].isSelect = !toggleSupportGraphicsCards[index].isSelect;
        return PcCaseSearchParameter(supportMotherBoards, toggleSupportGraphicsCards, colors);
      case 'カラー':
        var toggleColors = colors;
        toggleColors[index].isSelect = !toggleColors[index].isSelect;
        return PcCaseSearchParameter(supportMotherBoards, supportGraphicsCards, toggleColors);
      default:
        return this;
    }
  }
}
