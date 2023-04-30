import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

class CpuSearchParameter extends CategorySearchParameter {
  final Map<String, String> makers;
  final Map<String, String> processors;
  final Map<String, String> series;
  final Map<String, String> sockets;

  CpuSearchParameter(this.makers, this.processors, this.series, this.sockets);

  @override
  CategorySearchParameter clearSelectedParameter() {
    // TODO: implement clearSelectedParameter
    throw UnimplementedError();
  }

  @override
  List<String> selectedParameters() {
    // TODO: implement selectedParameters
    throw UnimplementedError();
  }
}

class CpuSearchParser {
  static const String standardPage = 'https://kakaku.com/pc/cpu/itemlist.aspx';
  static const String _makerSelector = '#menu > div.searchspec > div:nth-child(13) > ul > li';
  static const String _specsSelector = '#menu > div.searchspec > div:nth-child(17)';

  static Document? _document;

  static Future<CpuSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final makers = _parseMakerList()!;
    final processors = _parseProcessorList()!;
    final series = _parseSeriesList()!;
    final sockets = _parseSocketList();

    return CpuSearchParameter(makers, processors, series, sockets);
  }

  static Map<String, String>? _parseMakerList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> makerList = {};
    final makerListElement = _document!.querySelectorAll(_makerSelector);

    for (var element in makerListElement) {
      final makerName = element.text.split('（')[0];
      final makerParameter = element.querySelectorAll('a')[0].attributes['href']!.split('?')[1];

      // メーカー名が 'インテル' の場合は 'intel' に変換する
      if (makerName == 'インテル') {
        makerList['intel'] = makerParameter;
      } else {
        makerList[makerName] = makerParameter;
      }
    }
    return makerList;
  }

  static Map<String, String>? _parseProcessorList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> processorList = {};
    final processorListElement = _document!.querySelectorAll(_specsSelector);
    final openProcessorElement = processorListElement[0].querySelectorAll('ul.check.ultop');

    // プロセッサー情報は先頭8件とそれ以降で取得するindexが異なる為、分けて取得する

    // 先頭8件
    final firstProcessorElement = openProcessorElement[0].querySelectorAll('li');

    for (var element in firstProcessorElement) {
      if (element.text != 'プロセッサ名') {
        final processorName = element.text.split('（')[0];
        final processorParameterAtag = element.querySelectorAll('a');
        // atagが存在する場合のみ処理を行う
        if (processorParameterAtag.isNotEmpty) {
          final processorParameter = processorParameterAtag[0].attributes['href']!.split('?')[1];
          processorList[processorName] = processorParameter;
        }
      }
    }

    //それ以降
    final afterProcessorElement = openProcessorElement[1].querySelectorAll('li');
    for (var element in afterProcessorElement) {
      final processorName = element.text.split('（')[0];
      final processorParameterAtag = element.querySelectorAll('a');
      // atagが存在する場合のみ処理を行う
      if (processorParameterAtag.isNotEmpty) {
        // パラメーター取得
        final processorParameter = processorParameterAtag[0].attributes['href']!.split('?')[1];
        processorList[processorName] = processorParameter;
      }
    }

    return processorList;
  }

  static Map<String, String>? _parseSeriesList() {
    if (_document == null) {
      return null;
    }
    Map<String, String> seriesList = {};
    final processorListElement = _document!.querySelectorAll(_specsSelector);
    final openProcessorElement = processorListElement[0].querySelectorAll('ul.check');

    // 世代の情報があるindexを探す
    int seriesNodeIndex = 0;
    for (int i = 0; i < openProcessorElement.length; i++) {
      final sectionName = openProcessorElement[i].querySelectorAll('li')[0].text;
      // 先頭が '世代' の場合はindexを保持する
      if (sectionName == '世代') {
        seriesNodeIndex = i;
        break;
      }
    }

    final seriesElement = openProcessorElement[seriesNodeIndex].querySelectorAll('li');
    for (var element in seriesElement) {
      final seriesName = element.text.split('（')[0];
      final seriesParameterAtag = element.querySelectorAll('a');
      // atagが存在する場合のみ処理を行う
      if (seriesParameterAtag.isNotEmpty) {
        // パラメーター取得
        final seriesParameter = seriesParameterAtag[0].attributes['href']!.split('?')[1];
        seriesList[seriesName] = seriesParameter;
      }
    }
    return seriesList;
  }

  static Map<String, String> _parseSocketList() {
    if (_document == null) {
      return {};
    }
    Map<String, String> socketList = {};
    final socketListElement = _document!.querySelectorAll(_specsSelector);
    final openSocketElement = socketListElement[0].querySelectorAll('ul.check');

    //ソケットの情報があるindexを探す
    int seriesNodeIndex = 0;
    for (int i = 0; i < openSocketElement.length; i++) {
      final sectionName = openSocketElement[i].querySelectorAll('li')[0].text;
      // 先頭が 'ソケット形状' の場合はindexを保持する
      if (sectionName.contains('ソケット形状')) {
        seriesNodeIndex = i;
        break;
      }
    }

    // ソケット情報は先頭5件とそれ以降で取得するindexが異なる為、分けて取得する

    // 先頭5件
    final firstSocketElement = openSocketElement[seriesNodeIndex].querySelectorAll('li');

    firstSocketElement.forEach((element) {
      if (!element.text.contains('ソケット形状')) {
        final socketName = element.text.split('（')[0];
        final socketParameterAtag = element.querySelectorAll('a');
        // atagが存在する場合のみ処理を行う
        if (socketParameterAtag.isNotEmpty) {
          // パラメーター取得
          final socketParameter = socketParameterAtag[0].attributes['href']!.split('?')[1];
          socketList[socketName] = socketParameter;
        }
      }
    });

    //それ以降
    final afterSocketElement = openSocketElement[seriesNodeIndex + 1].querySelectorAll('li');
    afterSocketElement.forEach((element) {
      final socketName = element.text.split('（')[0];
      final socketParameterAtag = element.querySelectorAll('a');
      // atagが存在する場合のみ処理を行う
      if (socketParameterAtag.isNotEmpty) {
        // パラメーター取得
        final socketParameter = socketParameterAtag[0].attributes['href']!.split('?')[1];
        socketList[socketName] = socketParameter;
      }
    });

    return socketList;
  }
}
