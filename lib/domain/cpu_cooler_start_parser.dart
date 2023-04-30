import 'package:custom_pc/domain/document_repository.dart';
import 'package:html/dom.dart';

import '../models/category_search_parameter.dart';

class CpuCoolerSearchParameter extends CategorySearchParameter {
  final List<PartsParameter> makers;
  final List<PartsParameter> intelSockets;
  final List<PartsParameter> amdSockets;
  final List<PartsParameter> type = [PartsParameter('トップフロー型', 'pdf_Spec101=1'), PartsParameter('サイドフロー型', 'pdf_Spec101=2'), PartsParameter('水冷型', 'pdf_Spec101=3')];

  CpuCoolerSearchParameter(this.makers, this.intelSockets, this.amdSockets);

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

  CpuCoolerSearchParameter clearSelectedParameter() {
    final List<PartsParameter> clearMaker = [];
    for (var element in makers) {
      element.isSelect = false;
      clearMaker.add(element);
    }
    final List<PartsParameter> clearIntelSocket = [];
    for (var element in intelSockets) {
      element.isSelect = false;
      clearIntelSocket.add(element);
    }
    final List<PartsParameter> clearAmdSocket = [];
    for (var element in makers) {
      element.isSelect = false;
      clearAmdSocket.add(element);
    }
    final List<PartsParameter> clearType = [];
    for (var element in makers) {
      element.isSelect = false;
      clearType.add(element);
    }

    return CpuCoolerSearchParameter(clearMaker, clearIntelSocket, clearType);
  }
}

class PartsParameter {
  final String key;
  final String value;
  bool isSelect = false;
  PartsParameter(this.key, this.value);
}

class CpuCoolerSearchParser {
  static const String standardPage = 'https://kakaku.com/pc/cpu-cooler/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<CpuCoolerSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final makers = _parseMakerList()!;
    final intelSockets = _parseIntelSocketList()!;
    final amdSockets = _parseAmdSocketList()!;

    return CpuCoolerSearchParameter(makers, intelSockets, amdSockets);
  }

  static List<PartsParameter>? _parseMakerList() {
    if (_document == null) {
      return null;
    }
    List<PartsParameter> makerList = [];
    // メーカー名のリストは3番目の div にある
    final makerListElement = _document!.querySelectorAll(_parameterSelector)[2].querySelectorAll('ul > li');
    for (var element in makerListElement) {
      final makerName = element.text.split('（')[0].split('(')[0];
      final makerParameterAtag = element.querySelectorAll('a');
      if (makerParameterAtag.isNotEmpty) {
        final makerParameter = makerParameterAtag[0].attributes['href']!.split('?')[1];
        makerList.add(PartsParameter(makerName, makerParameter));
      }
    }
    return makerList;
  }

  static List<PartsParameter>? _parseIntelSocketList() {
    if (_document == null) {
      return null;
    }
    List<PartsParameter> intelSocketList = [];
    // インテルソケットのリストは4番目の div にある
    final intelSocketListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul > li');

    for (var element in intelSocketListElement) {
      final intelSocketName = element.text.split('（')[0];
      final intelSocketParameterAtag = element.querySelectorAll('a');
      if (intelSocketParameterAtag.isNotEmpty) {
        final intelSocketParameter = intelSocketParameterAtag[0].attributes['href']!.split('?')[1];
        intelSocketList.add(PartsParameter(intelSocketName, intelSocketParameter));
      }
    }
    return intelSocketList;
  }

  static List<PartsParameter>? _parseAmdSocketList() {
    if (_document == null) {
      return null;
    }
    List<PartsParameter> amdSocketList = [];
    // AMDソケットのリストは5番目の div にある
    final amdSocketListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul > li');

    for (var element in amdSocketListElement) {
      final amdSocketName = element.text.split('（')[0];
      final amdSocketParameterAtag = element.querySelectorAll('a');
      if (amdSocketParameterAtag.isNotEmpty) {
        final amdSocketParameter = amdSocketParameterAtag[0].attributes['href']!.split('?')[1];
        amdSocketList.add(PartsParameter(amdSocketName, amdSocketParameter));

        print(amdSocketName);
      }
    }
    return amdSocketList;
  }
}
