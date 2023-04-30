import 'package:custom_pc/domain/cpu_cooler_search_parameter_parser.dart';

import '../category_search_parameter.dart';

class CpuCoolerSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> makers;
  final List<PartsSearchParameter> intelSockets;
  final List<PartsSearchParameter> amdSockets;
  final List<PartsSearchParameter> type;

  CpuCoolerSearchParameter(this.makers, this.intelSockets, this.amdSockets, this.type);

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in makers) {
      if (element.isSelect) {
        params.add(element.value);
      }
    }
    for (var element in intelSockets) {
      if (element.isSelect) {
        params.add(element.value);
      }
    }
    for (var element in amdSockets) {
      if (element.isSelect) {
        params.add(element.value);
      }
    }
    for (var element in type) {
      if (element.isSelect) {
        params.add(element.value);
      }
    }
    return params;
  }

  @override
  CpuCoolerSearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearMaker = [];
    for (var element in makers) {
      element.isSelect = false;
      clearMaker.add(element);
    }
    final List<PartsSearchParameter> clearIntelSocket = [];
    for (var element in intelSockets) {
      element.isSelect = false;
      clearIntelSocket.add(element);
    }
    final List<PartsSearchParameter> clearAmdSocket = [];
    for (var element in amdSockets) {
      element.isSelect = false;
      clearAmdSocket.add(element);
    }
    final List<PartsSearchParameter> clearType = [];
    for (var element in type) {
      element.isSelect = false;
      clearType.add(element);
    }

    return CpuCoolerSearchParameter(clearMaker, clearIntelSocket, clearType, clearType);
  }

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'メーカー': makers},
      {'intel\nソケット': intelSockets},
      {'AMD\nソケット': amdSockets},
      {'タイプ': type},
    ];
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case 'メーカー':
        var toggleMaker = makers;
        toggleMaker[index].isSelect = !makers[index].isSelect;
        return CpuCoolerSearchParameter(toggleMaker, intelSockets, amdSockets, type);
      case 'intel\nソケット':
        var toggleIntelSockets = intelSockets;
        toggleIntelSockets[index].isSelect = !intelSockets[index].isSelect;
        return CpuCoolerSearchParameter(makers, toggleIntelSockets, amdSockets, type);
      case 'AMD\nソケット':
        var toggleAmdSockets = amdSockets;
        toggleAmdSockets[index].isSelect = !amdSockets[index].isSelect;
        return CpuCoolerSearchParameter(makers, intelSockets, toggleAmdSockets, type);
      case 'タイプ':
        var toggleType = type;
        toggleType[index].isSelect = !type[index].isSelect;
        return CpuCoolerSearchParameter(makers, intelSockets, amdSockets, toggleType);
      default:
        return this;
    }
  }

  @override
  String standardPage() {
    return CpuCoolerSearchParameterParser.standardPage;
  }
}
