import 'package:html/dom.dart';

import '../../models/category_search_parameter.dart';
import '../../models/search_parameters/memory_search_parameter.dart';
import '../../models/search_parameters/mother_board_search_parameter.dart';
import '../document_repository.dart';

class MotherBoardSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/motherboard/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<MotherBoardSearchParameter?> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final intelSockets = _parseIntelSockets()!;
    final amdSockets = _parseAmdSockets()!;
    final formFactors = _parseFormfactor()!;
    final memoryType = _parseMemoryTypes()!;
    return MotherBoardSearchParameter(intelSockets, amdSockets, formFactors, memoryType);
  }

  static List<PartsSearchParameter>? _parseIntelSockets() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> intelSocketList = [];
    // CPUソケット(intel)のリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstIntelSocketListElement = specListElement[5].querySelectorAll('li');
    final afterIntelSocketListElement = specListElement[6].querySelectorAll('li');

    // CPUソケット(intel)のリストは2つに分かれているので、それぞれのリストごとに処理する
    // 先頭
    for (var element in firstIntelSocketListElement) {
      if (element.text.contains('CPUソケット(intel)')) {
        continue;
      }
      final intelSocketName = element.text.split('（')[0];
      final intelSocketParameterAtag = element.querySelectorAll('a');
      if (intelSocketParameterAtag.isNotEmpty) {
        final intelSocketParameter = intelSocketParameterAtag[0].attributes['href']!.split('?')[1];
        intelSocketList.add(PartsSearchParameter(intelSocketName, intelSocketParameter));
      }
    }

    // 以降
    for (var element in afterIntelSocketListElement) {
      final intelSocketName = element.text.split('（')[0];
      final intelSocketParameterAtag = element.querySelectorAll('a');
      if (intelSocketParameterAtag.isNotEmpty) {
        final intelSocketParameter = intelSocketParameterAtag[0].attributes['href']!.split('?')[1];
        intelSocketList.add(PartsSearchParameter(intelSocketName, intelSocketParameter));
      }
    }
    return intelSocketList;
  }

  static  List<PartsSearchParameter>? _parseAmdSockets() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> amdSocketList = [];
    // CPUソケット(AMD)のリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstAmdSocketListElement = specListElement[7].querySelectorAll('li');
    final afterAmdSocketListElement = specListElement[8].querySelectorAll('li');

    // CPUソケット(AMD)のリストは2つに分かれているので、それぞれのリストごとに処理する
    // 先頭
    for (var element in firstAmdSocketListElement) {
      if (element.text.contains('CPUソケット(AMD)')) {
        continue;
      }
      final amdSocketName = element.text.split('（')[0];
      final amdSocketParameterAtag = element.querySelectorAll('a');
      if (amdSocketParameterAtag.isNotEmpty) {
        final amdSocketParameter = amdSocketParameterAtag[0].attributes['href']!.split('?')[1];
        amdSocketList.add(PartsSearchParameter(amdSocketName, amdSocketParameter));
      }
    }

    // 以降
    for (var element in afterAmdSocketListElement) {
      final amdSocketName = element.text.split('（')[0];
      final amdSocketParameterAtag = element.querySelectorAll('a');
      if (amdSocketParameterAtag.isNotEmpty) {
        final amdSocketParameter = amdSocketParameterAtag[0].attributes['href']!.split('?')[1];
        amdSocketList.add(PartsSearchParameter(amdSocketName, amdSocketParameter));
      }
    }
    return amdSocketList;
  }

  static List<PartsSearchParameter>? _parseFormfactor() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> formfactorList = [];
    // フォームファクターのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstFormfactorListElement = specListElement[9].querySelectorAll('li');
    final afterFormfactorListElement = specListElement[10].querySelectorAll('li');

    // フォームファクターのリストは2つに分かれているので、それぞれのリストごとに処理する
    // 先頭
    for (var element in firstFormfactorListElement) {
      if (element.text.contains('フォームファクター')) {
        continue;
      }
      final formfactorName = element.text.split('（')[0];
      final formfactorParameterAtag = element.querySelectorAll('a');
      if (formfactorParameterAtag.isNotEmpty) {
        final formfactorParameter = formfactorParameterAtag[0].attributes['href']!.split('?')[1];
        formfactorList.add(PartsSearchParameter(formfactorName, formfactorParameter));
      }
    }

    // 以降
    for (var element in afterFormfactorListElement) {
      final formfactorName = element.text.split('（')[0];
      final formfactorParameterAtag = element.querySelectorAll('a');
      if (formfactorParameterAtag.isNotEmpty) {
        final formfactorParameter = formfactorParameterAtag[0].attributes['href']!.split('?')[1];
        formfactorList.add(PartsSearchParameter(formfactorName, formfactorParameter));
      }
    }
    return formfactorList;
  }

  static List<PartsSearchParameter>? _parseMemoryTypes() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> memoryTypeList = [];
    // メモリタイプのリストは3番目の div の中の 2番目の ul にある
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final firstMemoryTypeListElement = specListElement[12].querySelectorAll('li');

    for (var element in firstMemoryTypeListElement) {
      if (element.text.contains('メモリタイプ')) {
        continue;
      }
      final memoryTypeName = element.text.split('（')[0];
      final memoryTypeParameterAtag = element.querySelectorAll('a');
      if (memoryTypeParameterAtag.isNotEmpty) {
        final memoryTypeParameter = memoryTypeParameterAtag[0].attributes['href']!.split('?')[1];
        memoryTypeList.add(PartsSearchParameter(memoryTypeName, memoryTypeParameter));
      } else {
        final memoryTypeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = memoryTypeParameter.split("changeLocation('")[1].split("');")[0];
        memoryTypeList.add(PartsSearchParameter(memoryTypeName, split));
      }
    }
    return memoryTypeList;
  }
}