import '../category_search_parameter.dart';

class CpuCoolerSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> makers;
  final List<PartsSearchParameter> intelSockets;
  final List<PartsSearchParameter> amdSockets;
  final List<PartsSearchParameter> type = [PartsSearchParameter('トップフロー型', 'pdf_Spec101=1'), PartsSearchParameter('サイドフロー型', 'pdf_Spec101=2'), PartsSearchParameter('水冷型', 'pdf_Spec101=3')];

  CpuCoolerSearchParameter(this.makers, this.intelSockets, this.amdSockets);

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
    for (var element in makers) {
      element.isSelect = false;
      clearAmdSocket.add(element);
    }
    final List<PartsSearchParameter> clearType = [];
    for (var element in makers) {
      element.isSelect = false;
      clearType.add(element);
    }

    return CpuCoolerSearchParameter(clearMaker, clearIntelSocket, clearType);
  }
}
