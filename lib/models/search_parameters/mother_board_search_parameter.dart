import 'package:custom_pc/domain/search_parameter_parser/mother_board_search_parameter_parser.dart';
import 'package:custom_pc/models/category_search_parameter.dart';

class MotherBoardSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> intelSockets;
  final List<PartsSearchParameter> amdSockets;
  final List<PartsSearchParameter> formFactors;
  final List<PartsSearchParameter> memoryType;

  MotherBoardSearchParameter(this.intelSockets, this.amdSockets, this.formFactors, this.memoryType);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'CPUソケット(intel)': intelSockets},
      {'CPUソケット(AMD)': amdSockets},
      {'フォームファクタ': formFactors},
      {'メモリタイプ': memoryType},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearIntelSockets = [];
    for (var element in intelSockets) {
      element.isSelect = false;
      clearIntelSockets.add(element);
    }
    final List<PartsSearchParameter> clearAmdSockets = [];
    for (var element in amdSockets) {
      element.isSelect = false;
      clearAmdSockets.add(element);
    }
    final List<PartsSearchParameter> clearFormFactors = [];
    for (var element in formFactors) {
      element.isSelect = false;
      clearFormFactors.add(element);
    }
    final List<PartsSearchParameter> clearMemoryType = [];
    for (var element in memoryType) {
      element.isSelect = false;
      clearMemoryType.add(element);
    }

    return MotherBoardSearchParameter(clearIntelSockets, clearAmdSockets, clearFormFactors, clearMemoryType);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in intelSockets) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in amdSockets) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in formFactors) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in memoryType) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in intelSockets) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in amdSockets) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in formFactors) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in memoryType) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return MotherBoardSearchParameterParser.standardPage;
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case 'CPUソケット(intel)':
        var toggleIntelSockets = intelSockets;
        toggleIntelSockets[index].isSelect = !intelSockets[index].isSelect;
        return MotherBoardSearchParameter(toggleIntelSockets, amdSockets, formFactors, memoryType);
      case 'CPUソケット(AMD)':
        var toggleAmdSockets = amdSockets;
        toggleAmdSockets[index].isSelect = !amdSockets[index].isSelect;
        return MotherBoardSearchParameter(intelSockets, toggleAmdSockets, formFactors, memoryType);
      case 'フォームファクタ':
        var toggleFormFactors = formFactors;
        toggleFormFactors[index].isSelect = !formFactors[index].isSelect;
        return MotherBoardSearchParameter(intelSockets, amdSockets, toggleFormFactors, memoryType);
      case 'メモリタイプ':
        var toggleMemoryType = memoryType;
        toggleMemoryType[index].isSelect = !memoryType[index].isSelect;
        return MotherBoardSearchParameter(intelSockets, amdSockets, formFactors, toggleMemoryType);
      default:
        return this;
    }
  }
}
