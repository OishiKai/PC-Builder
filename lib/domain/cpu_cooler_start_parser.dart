

import 'package:custom_pc/domain/document_repository.dart';
import 'package:html/dom.dart';

import '../models/category_search_parameter.dart';

class CpuCoolerSearchParameter extends CategorySearchParameter {
  final Map<String, String> makers;
  final Map<String, String> intelSockets;
  final Map<String, String> amdSockets;
  final Map<String, String> type = {
    'トップフロー型': 'pdf_Spec101=1',
    'サイドフロー型': 'pdf_Spec101=2',
    '水冷型': 'pdf_Spec101=3',
  };

  CpuCoolerSearchParameter(this.makers, this.intelSockets, this.amdSockets);
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

  static Map<String, String>? _parseMakerList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> makerList = {};
    // メーカー名のリストは3番目の div にある
    final makerListElement = _document!.querySelectorAll(_parameterSelector)[2].querySelectorAll('ul > li');
    for (var element in makerListElement) {
      final makerName = element.text.split('(')[0];
      final makerParameterAtag = element.querySelectorAll('a');
      if (makerParameterAtag.isNotEmpty) {
        final makerParameter = makerParameterAtag[0].attributes['href']!.split('?')[1];
        makerList[makerName] = makerParameter;
      }
    }
    return makerList;
  }

  static Map<String, String>? _parseIntelSocketList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> intelSocketList = {};
    // インテルソケットのリストは4番目の div にある
    final intelSocketListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul > li');
    
    for (var element in intelSocketListElement) {
      final intelSocketName = element.text.split('（')[0];
      final intelSocketParameterAtag = element.querySelectorAll('a');
      if (intelSocketParameterAtag.isNotEmpty) {
        final intelSocketParameter = intelSocketParameterAtag[0].attributes['href']!.split('?')[1];
        intelSocketList[intelSocketName] = intelSocketParameter;
      }
    }
    return intelSocketList;
  }

  static Map<String, String>? _parseAmdSocketList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> amdSocketList = {};
    // AMDソケットのリストは5番目の div にある
    final amdSocketListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul > li');
    
    for (var element in amdSocketListElement) {
      final amdSocketName = element.text.split('（')[0];
      final amdSocketParameterAtag = element.querySelectorAll('a');
      if (amdSocketParameterAtag.isNotEmpty) {
        final amdSocketParameter = amdSocketParameterAtag[0].attributes['href']!.split('?')[1];
        amdSocketList[amdSocketName] = amdSocketParameter;
      }
    }
    return amdSocketList;
  }
}