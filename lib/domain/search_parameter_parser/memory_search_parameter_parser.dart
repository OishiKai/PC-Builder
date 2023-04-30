import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/memory_search_parameter.dart';

class MemorySearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/pc-memory/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<MemorySearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final volume = _parseVolumeList()!;
    final interface = _parseInterfaceList()!;
    final type = _parseTypeList()!;
    return MemorySearchParameter(volume, interface, type);
  }

  static List<PartsSearchParameter>? _parseVolumeList() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> volumeList = [];
    // 容量のリストは3番目の div の中の 1番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[0];
    final volumeListElement = specListElement.querySelectorAll('li');

    for (var element in volumeListElement) {
      if (element.text.contains('メモリ容量')) {
        continue;
      }
      final volumeName = element.text.split('（')[0];
      final volumeParameterAtag = element.querySelectorAll('a');
      if (volumeParameterAtag.isNotEmpty) {
        final volumeParameter = volumeParameterAtag[0].attributes['href']!.split('?')[1];
        volumeList.add(PartsSearchParameter(volumeName, volumeParameter));
      }
    }
    return volumeList;
  }

  static List<PartsSearchParameter>? _parseInterfaceList() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> interfaceList = [];
    // インターフェースのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[2];
    final interfaceListElement = specListElement.querySelectorAll('li');

    for (var element in interfaceListElement) {
      if (element.text.contains('メモリインターフェース')) {
        continue;
      }
      final interfaceName = element.text.split('（')[0];
      final interfaceParameterAtag = element.querySelectorAll('a');
      if (interfaceParameterAtag.isNotEmpty) {
        final interfaceParameter = interfaceParameterAtag[0].attributes['href']!.split('?')[1];
        interfaceList.add(PartsSearchParameter(interfaceName, interfaceParameter));
      }
    }
    return interfaceList;
  }

  static List<PartsSearchParameter>? _parseTypeList() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> typeList = [];
    // タイプのリストは3番目の div の中の 3番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul')[3];
    final typeListElement = specListElement.querySelectorAll('li');

    for (var element in typeListElement) {
      if (element.text.contains('メモリタイプ')) {
        continue;
      }
      final typeName = element.text.split('（')[0];
      final typeParameterAtag = element.querySelectorAll('a');
      if (typeParameterAtag.isNotEmpty) {
        final typeParameter = typeParameterAtag[0].attributes['href']!.split('?')[1];
        typeList.add(PartsSearchParameter(typeName, typeParameter));
      }
    }
    return typeList;
  }
}
