import 'package:custom_pc/domain/document_repository.dart';
import 'package:html/dom.dart';

import '../../models/category_search_parameter.dart';
import '../../models/search_parameters/cpu_cooler_search_parameter.dart';
import '../parts_list_search_parameter.dart';

class CpuCoolerSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/cpu-cooler/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<CpuCoolerSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final makers = _parseMakerList();
    final intelSockets = _parseIntelSocketList();
    final amdSockets = _parseAmdSocketList();
    final type = [PartsSearchParameter('トップフロー型', 'pdf_Spec101=1'), PartsSearchParameter('サイドフロー型', 'pdf_Spec101=2'), PartsSearchParameter('水冷型', 'pdf_Spec101=3')];
    return CpuCoolerSearchParameter(makers, intelSockets, amdSockets, type);
  }

  static List<PartsSearchParameter> _parseMakerList() {
    List<PartsSearchParameter> makerList = [];
    // メーカー名のリストは3番目の div にある
    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final makerListElement = _document!.querySelectorAll(_parameterSelector)[2].querySelectorAll('ul > li');
    makerList.addAll(PartsListSearchParameter.takeOutParameters(makerListElement));
    return makerList;
  }

  static List<PartsSearchParameter> _parseIntelSocketList() {
    List<PartsSearchParameter> intelSocketList = [];
    // インテルソケットのリストは4番目の div にある
    final intelSocketListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul > li');
    intelSocketList.addAll(PartsListSearchParameter.takeOutParameters(intelSocketListElement));
    return intelSocketList;
  }

  static List<PartsSearchParameter> _parseAmdSocketList() {
    List<PartsSearchParameter> amdSocketList = [];
    // AMDソケットのリストは5番目の div にある
    final amdSocketListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul > li');
    amdSocketList.addAll(PartsListSearchParameter.takeOutParameters(amdSocketListElement));
    return amdSocketList;
  }
}
