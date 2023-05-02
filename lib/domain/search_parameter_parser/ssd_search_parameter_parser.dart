import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/ssd_search_parameter.dart';
import '../document_repository.dart';

class SsdSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/ssd/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<SsdSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final volumes = _parseVolume()!;
    final types = _parseType()!;
    final interfaces = _parseInterface()!;
    return SsdSearchParameter(volumes, types, interfaces);
  }

  static List<PartsSearchParameter>? _parseVolume() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> volumeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final volumeListElement = specListElement[0].querySelectorAll('li');

    for (var element in volumeListElement) {
      final volumeName = element.text.split('（')[0];
      final volumeParameterAtag = element.querySelectorAll('a');
      if (volumeParameterAtag.isNotEmpty) {
        final volumeParameter = volumeParameterAtag[0].attributes['href']!.split('?')[1];
        volumeList.add(PartsSearchParameter(volumeName, volumeParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final volumeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = volumeParameter.split("changeLocation('")[1].split("');")[0];
        volumeList.add(PartsSearchParameter(volumeName, split));
      }
    }
    return volumeList;
  }

  static List<PartsSearchParameter>? _parseType() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> typeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final typeListElement = specListElement[1].querySelectorAll('li');

    for (var element in typeListElement) {
      final typeName = element.text.split('（')[0];
      final typeParameterAtag = element.querySelectorAll('a');
      if (typeParameterAtag.isNotEmpty) {
        final typeParameter = typeParameterAtag[0].attributes['href']!.split('?')[1];
        typeList.add(PartsSearchParameter(typeName, typeParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final typeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = typeParameter.split("changeLocation('")[1].split("');")[0];
        typeList.add(PartsSearchParameter(typeName, split));
      }
    }
    return typeList;
  }



  static List<PartsSearchParameter>? _parseInterface() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> interfaceList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final interfaceListElement = specListElement[2].querySelectorAll('li');

    for (var element in interfaceListElement) {
      final interfaceName = element.text.split('（')[0];
      final interfaceParameterAtag = element.querySelectorAll('a');
      if (interfaceParameterAtag.isNotEmpty) {
        final interfaceParameter = interfaceParameterAtag[0].attributes['href']!.split('?')[1];
        interfaceList.add(PartsSearchParameter(interfaceName, interfaceParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final interfaceParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = interfaceParameter.split("changeLocation('")[1].split("');")[0];
        interfaceList.add(PartsSearchParameter(interfaceName, split));
      }
    }
    return interfaceList;
  }
}
