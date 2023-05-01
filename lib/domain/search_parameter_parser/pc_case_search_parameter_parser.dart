
import 'package:custom_pc/models/search_parameters/pc_case_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/category_search_parameter.dart';
import '../document_repository.dart';

class PcCaseSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/pc-case/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';
  static Document? _document;

  static Future<PcCaseSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final supportMotherBoards = _parseSupportMotherBoard()!;
    final supprotGraphicsCard = _parseSupportGraphicsCard()!;
    final colors = _parseColors()!;
    
    return PcCaseSearchParameter(supportMotherBoards, supprotGraphicsCard, colors);
  }

  static List<PartsSearchParameter>? _parseSupportMotherBoard() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> supportMotherBoardList = [];
    final supportMBListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul > li');

    for (var element in supportMBListElement) {
      final supportMBName = element.text.split('（')[0];
      // 最大対応マザーボードサイズの場合はループを抜ける
      if (supportMBName.contains('〜')) { break;}

      final supportMBParameterAtag = element.querySelectorAll('a');

      if (supportMBParameterAtag.isNotEmpty) {
        final supportMBParameter = supportMBParameterAtag[0].attributes['href']!.split('?')[1];
        supportMotherBoardList.add(PartsSearchParameter(supportMBName, supportMBParameter));

      } else if (element.querySelectorAll('span').isNotEmpty) {
        final supportMBParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = supportMBParameter.split("changeLocation('")[1].split("');")[0];
        supportMotherBoardList.add(PartsSearchParameter(supportMBName, split));
      }
    }
    return supportMotherBoardList; 
  }

  static List<PartsSearchParameter>? _parseSupportGraphicsCard() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> supportGraphicsCardList = [];
    final supportGraphicsCardListElement = _document!.querySelectorAll(_parameterSelector)[7].querySelectorAll('ul > li');

    for (var element in supportGraphicsCardListElement) {
      final supportGraphicsCardName = element.text.split('（')[0];
      final supportGraphicsCardParameterAtag = element.querySelectorAll('a');

      if (supportGraphicsCardParameterAtag.isNotEmpty) {
        final supportGraphicsCardParameter = supportGraphicsCardParameterAtag[0].attributes['href']!.split('?')[1];

        // 最大グラフィックボードサイズ以外の情報の場合はループを抜ける
        if (supportGraphicsCardParameter.contains('Spec308')) { break;}
        supportGraphicsCardList.add(PartsSearchParameter(supportGraphicsCardName, supportGraphicsCardParameter));

      } else if (element.querySelectorAll('span').isNotEmpty) {

        final supportGraphicsCardParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = supportGraphicsCardParameter.split("changeLocation('")[1].split("');")[0];

        // 最大グラフィックボードサイズ以外の情報の場合はループを抜ける
        if (supportGraphicsCardParameter.contains('Spec308')) { break;}
        supportGraphicsCardList.add(PartsSearchParameter(supportGraphicsCardName, split));
      }
    }
    return supportGraphicsCardList; 
  }

  static List<PartsSearchParameter>? _parseColors() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> colorsList = [];
    final colorsListElement = _document!.querySelectorAll(_parameterSelector)[12].querySelectorAll('ul > li');

    for (var element in colorsListElement) {
      final colorsName = element.text.split('(')[0];
      if (colorsName.contains('その他')) { break;}
      final colorsParameterAtag = element.querySelectorAll('a');

      if (colorsParameterAtag.isNotEmpty) {
        final colorsParameter = colorsParameterAtag[0].attributes['href']!.split('?')[1];
        colorsList.add(PartsSearchParameter(colorsName, colorsParameter));

      } else if (element.querySelectorAll('span').isNotEmpty) {
        final colorsParameter = element.querySelectorAll('span')[0].attributes['onclick']!;
        final split = colorsParameter.split("changeLocation('")[1].split("');")[0];
        colorsList.add(PartsSearchParameter(colorsName, split));
      }
    }
    return colorsList;
  }
}
