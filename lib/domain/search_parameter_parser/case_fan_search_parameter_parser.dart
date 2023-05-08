import 'package:custom_pc/domain/parts_list_search_parameter.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/search_parameters/case_fan_search_parameter.dart';
import 'package:html/dom.dart';

import '../document_repository.dart';

class CaseFanSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/case-fan/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<CaseFanSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final makers = _parseMaker();
    final size = _parseSize();
    final airVolume = _parseAirVolume();
    return CaseFanSearchParameter(makers, size, airVolume);
  }

  static List<PartsSearchParameter> _parseMaker() {
    List<PartsSearchParameter> makerList = [];

    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final specListElement = _document!.querySelectorAll(_parameterSelector)[2].querySelectorAll('ul');
    // デフォルトで表示されている部分
    final makerListElement = specListElement[0].querySelectorAll('li');
    // 「もっと見る」を押した後に表示される部分
    final makerListElementHidden = specListElement[1].querySelectorAll('li');

    makerList.addAll(PartsListSearchParameter.takeOutParameters(makerListElement));
    makerList.addAll(PartsListSearchParameter.takeOutParameters(makerListElementHidden));
    return makerList;
  }

  static List<PartsSearchParameter> _parseSize() {
    List<PartsSearchParameter> sizeList = [];

    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final sizeListElement = specListElement[0].querySelectorAll('li');

    sizeList.addAll(PartsListSearchParameter.takeOutParameters(sizeListElement));
    return sizeList;
  }

  static List<PartsSearchParameter> _parseAirVolume() {
    List<PartsSearchParameter> airVolumeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final airVolumeListElement = specListElement[2].querySelectorAll('li');

    airVolumeList.addAll(PartsListSearchParameter.takeOutParameters(airVolumeListElement));
    return airVolumeList;
  }
}