import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/ssd_search_parameter.dart';
import '../document_repository.dart';
import '../parts_list_search_parameter.dart';

class SsdSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/ssd/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<SsdSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final volumes = _parseVolume();
    final types = _parseType();
    final interfaces = _parseInterface();
    return SsdSearchParameter(volumes, types, interfaces);
  }

  static List<PartsSearchParameter> _parseVolume() {
    List<PartsSearchParameter> volumeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final volumeListElement = specListElement[0].querySelectorAll('li');
    volumeList.addAll(PartsListSearchParameter.takeOutParameters(volumeListElement));
    return volumeList;
  }

  static List<PartsSearchParameter> _parseType() {
    List<PartsSearchParameter> typeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final typeListElement = specListElement[1].querySelectorAll('li');
    typeList.addAll(PartsListSearchParameter.takeOutParameters(typeListElement));
    return typeList;
  }

  static List<PartsSearchParameter> _parseInterface() {
    List<PartsSearchParameter> interfaceList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final interfaceListElement = specListElement[2].querySelectorAll('li');
    interfaceList.addAll(PartsListSearchParameter.takeOutParameters(interfaceListElement));
    return interfaceList;
  }
}
