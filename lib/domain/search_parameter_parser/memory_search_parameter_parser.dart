import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/memory_search_parameter.dart';
import '../parts_list_search_parameter.dart';

class MemorySearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/pc-memory/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<MemorySearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final volume = _parseVolumeList();
    final interface = _parseInterfaceList();
    final type = _parseTypeList();
    return MemorySearchParameter(volume, interface, type);
  }

  static List<PartsSearchParameter> _parseVolumeList() {
    List<PartsSearchParameter> volumeList = [];
    // 容量のリストは3番目の div の中の 1番目の ul にある
    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[0];
    final volumeListElement = specListElement.querySelectorAll('li');

    volumeList.addAll(PartsListSearchParameter.takeOutParameters(volumeListElement));
    return volumeList;
  }

  static List<PartsSearchParameter> _parseInterfaceList() {
    List<PartsSearchParameter> interfaceList = [];
    // インターフェースのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[2];
    final interfaceListElement = specListElement.querySelectorAll('li');

    interfaceList.addAll(PartsListSearchParameter.takeOutParameters(interfaceListElement));
    return interfaceList;
  }

  static List<PartsSearchParameter> _parseTypeList() {
    List<PartsSearchParameter> typeList = [];
    // タイプのリストは3番目の div の中の 3番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[3];
    final typeListElement = specListElement.querySelectorAll('li');

    typeList.addAll(PartsListSearchParameter.takeOutParameters(typeListElement));
    return typeList;
  }
}
