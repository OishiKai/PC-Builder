import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/search_parameters/power_unit_search_parameter.dart';
import 'package:html/dom.dart';

import '../document_repository.dart';

class PowerUnitSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/power-supply/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;

  static Future<PowerUnitSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final supportTypes = _parseSupportTypes()!;
    final powerSupplyCapacitys = _parsePowerSupplyCapacitys()!;
    return PowerUnitSearchParameter(supportTypes, powerSupplyCapacitys);
  }

  static List<PartsSearchParameter>? _parseSupportTypes() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> supportTypeList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul');

    for (var element in specListElement) {
      final supportTypeName = element.text.split('（')[0].replaceFirst('\n', '');
      final supportTypeParameterAtag = element.querySelectorAll('a');
      if (supportTypeParameterAtag.isNotEmpty) {
        final supportTypeParameter = supportTypeParameterAtag[0].attributes['href']!.split('?')[1];
        supportTypeList.add(PartsSearchParameter(supportTypeName, supportTypeParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final supportTypeParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = supportTypeParameter.split("changeLocation('")[1].split("');")[0];
        supportTypeList.add(PartsSearchParameter(supportTypeName, split));
      }
    }
    return supportTypeList;
  }

  static List<PartsSearchParameter>? _parsePowerSupplyCapacitys() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> powerSupplyCapacityList = [];
    final specListElement = _document!.querySelectorAll(_parameterSelector)[5].querySelectorAll('ul');
    final powerSupplyCapacityListElement = specListElement[0].querySelectorAll('li');

    for (var element in powerSupplyCapacityListElement) {
      final powerSupplyCapacityName = element.text.split('（')[0];
      final powerSupplyCapacityParameterAtag = element.querySelectorAll('a');
      if (powerSupplyCapacityParameterAtag.isNotEmpty) {
        final powerSupplyCapacityParameter = powerSupplyCapacityParameterAtag[0].attributes['href']!.split('?')[1];
        powerSupplyCapacityList.add(PartsSearchParameter(powerSupplyCapacityName, powerSupplyCapacityParameter));
      } else if (element.querySelectorAll('span').isNotEmpty) {
        final powerSupplyCapacityParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = powerSupplyCapacityParameter.split("changeLocation('")[1].split("');")[0];
        powerSupplyCapacityList.add(PartsSearchParameter(powerSupplyCapacityName, split));
      }
    }
    return powerSupplyCapacityList;
  }
}
