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
    final makers = _parseMaker()!;
    final size = _parseSize()!;
    final airVolume = _parseAirVolume()!;
    return CaseFanSearchParameter(makers, size, airVolume);
  }

  static List<PartsSearchParameter>? _parseMaker() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> makerList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[2].querySelectorAll('ul');
    final makerListElementHead = specListElement[0].querySelectorAll('li');
    final makerListElementTail = specListElement[1].querySelectorAll('li');

    for (var element in makerListElementHead) {
      final makerName = element.text.split('（')[0];
      final makerParameterAtag = element.querySelectorAll('a');
      if (makerParameterAtag.isNotEmpty) {
        final makerParameter = makerParameterAtag[0].attributes['href']!.split('?')[1];
        makerList.add(PartsSearchParameter(makerName, makerParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final makerParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = makerParameter.split("changeLocation('")[1].split("');")[0];
        makerList.add(PartsSearchParameter(makerName, split));
      }
    }

    for (var element in makerListElementTail) {
      final makerName = element.text.split('（')[0];
      final makerParameterAtag = element.querySelectorAll('a');
      if (makerParameterAtag.isNotEmpty) {
        final makerParameter = makerParameterAtag[0].attributes['href']!.split('?')[1];
        makerList.add(PartsSearchParameter(makerName, makerParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final makerParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = makerParameter.split("changeLocation('")[1].split("');")[0];
        makerList.add(PartsSearchParameter(makerName, split));
      }
    }
    return makerList;
  }

  static List<PartsSearchParameter>? _parseSize() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> sizeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final sizeListElement = specListElement[0].querySelectorAll('li');

    for (var element in sizeListElement) {
      final sizeName = element.text.split('（')[0];
      final sizeParameterAtag = element.querySelectorAll('a');
      if (sizeParameterAtag.isNotEmpty) {
        final sizeParameter = sizeParameterAtag[0].attributes['href']!.split('?')[1];
        sizeList.add(PartsSearchParameter(sizeName, sizeParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final sizeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = sizeParameter.split("changeLocation('")[1].split("');")[0];
        sizeList.add(PartsSearchParameter(sizeName, split));
      }
    }
    return sizeList;
  }

  static List<PartsSearchParameter>? _parseAirVolume() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> airVolumeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[3].querySelectorAll('ul');
    final airVolumeListElement = specListElement[2].querySelectorAll('li');

    for (var element in airVolumeListElement) {
      final airVolumeName = element.text.split('（')[0];
      final airVolumeParameterAtag = element.querySelectorAll('a');
      if (airVolumeParameterAtag.isNotEmpty) {
        final airVolumeParameter = airVolumeParameterAtag[0].attributes['href']!.split('?')[1];
        airVolumeList.add(PartsSearchParameter(airVolumeName, airVolumeParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final airVolumeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = airVolumeParameter.split("changeLocation('")[1].split("');")[0];
        airVolumeList.add(PartsSearchParameter(airVolumeName, split));
      }
    }
    return airVolumeList;
  }
}