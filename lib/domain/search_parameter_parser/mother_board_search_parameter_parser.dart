import 'package:html/dom.dart';

import '../../models/category_search_parameter.dart';
import '../../models/search_parameters/mother_board_search_parameter.dart';
import '../document_repository.dart';
import '../parts_list_search_parameter.dart';

class MotherBoardSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/motherboard/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<MotherBoardSearchParameter?> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final intelSockets = _parseIntelSockets();
    final amdSockets = _parseAmdSockets();
    final formFactors = _parseFormfactor();
    final memoryType = _parseMemoryTypes();
    return MotherBoardSearchParameter(intelSockets, amdSockets, formFactors, memoryType);
  }

  static List<PartsSearchParameter> _parseIntelSockets() {
    List<PartsSearchParameter> intelSocketList = [];
    // CPUソケット(intel)のリストは3番目の div の中の 2番目の ul にある
    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstIntelSocketListElement = specListElement[5].querySelectorAll('li');
    final afterIntelSocketListElement = specListElement[6].querySelectorAll('li');

    // CPUソケット(intel)情報は2つの ul に分かれているので、それぞれの ul に対して処理を行う
    // 先頭
    intelSocketList.addAll(PartsListSearchParameter.takeOutParameters(firstIntelSocketListElement));

    // 以降
    intelSocketList.addAll(PartsListSearchParameter.takeOutParameters(afterIntelSocketListElement));
    return intelSocketList;
  }

  static List<PartsSearchParameter> _parseAmdSockets() {
    List<PartsSearchParameter> amdSocketList = [];
    // CPUソケット(AMD)のリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstAmdSocketListElement = specListElement[7].querySelectorAll('li');
    final afterAmdSocketListElement = specListElement[8].querySelectorAll('li');

    // CPUソケット(AMD)のリストは2つに分かれているので、それぞれのリストごとに処理する
    // 先頭
    amdSocketList.addAll(PartsListSearchParameter.takeOutParameters(firstAmdSocketListElement));

    // 以降
    amdSocketList.addAll(PartsListSearchParameter.takeOutParameters(afterAmdSocketListElement));
    return amdSocketList;
  }

  static List<PartsSearchParameter> _parseFormfactor() {
    List<PartsSearchParameter> formfactorList = [];
    // フォームファクターのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstFormfactorListElement = specListElement[9].querySelectorAll('li');
    final afterFormfactorListElement = specListElement[10].querySelectorAll('li');

    // フォームファクターのリストは2つに分かれているので、それぞれのリストごとに処理する
    // 先頭
    formfactorList.addAll(PartsListSearchParameter.takeOutParameters(firstFormfactorListElement));

    // 以降
    formfactorList.addAll(PartsListSearchParameter.takeOutParameters(afterFormfactorListElement));
    return formfactorList;
  }

  static List<PartsSearchParameter> _parseMemoryTypes() {
    List<PartsSearchParameter> memoryTypeList = [];
    // メモリタイプのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstMemoryTypeListElement = specListElement[11].querySelectorAll('li');

    memoryTypeList.addAll(PartsListSearchParameter.takeOutParameters(firstMemoryTypeListElement));
    return memoryTypeList;
  }
}
