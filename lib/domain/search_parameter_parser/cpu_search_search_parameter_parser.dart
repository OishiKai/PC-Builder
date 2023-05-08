import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/cpu_search_parameter.dart';
import '../parts_list_search_parameter.dart';

class CpuSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/cpu/itemlist.aspx';
  static const String _makerSelector = '#menu > div.searchspec > div:nth-child(13) > ul > li';
  static const String _specsSelector = '#menu > div.searchspec > div:nth-child(17)';

  static Document? _document;

  static Future<CpuSearchParameter> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final makers = _parseMakerList();
    final processors = _parseProcessorList();
    final series = _parseSeriesList();
    final sockets = _parseSocketList();

    return CpuSearchParameter(makers, processors, series, sockets);
  }

  static List<PartsSearchParameter> _parseMakerList() {
    List<PartsSearchParameter> makerList = [];

    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final makerListElement = _document!.querySelectorAll(_makerSelector);
    makerList.addAll(PartsListSearchParameter.takeOutParameters(makerListElement));
    return makerList;
  }

  static List<PartsSearchParameter> _parseProcessorList() {
    List<PartsSearchParameter> processorList = [];

    final processorListElement = _document!.querySelectorAll(_specsSelector);
    final openProcessorElement = processorListElement[0].querySelectorAll('ul.check.ultop');

    // プロセッサー情報は先頭8件がデフォルトで表示されており、それ以降は「もっと見る」を押すことで表示される

    // 先頭8件
    final firstProcessorElement = openProcessorElement[0].querySelectorAll('li');
    processorList.addAll(PartsListSearchParameter.takeOutParameters(firstProcessorElement));

    //それ以降
    final afterProcessorElement = openProcessorElement[1].querySelectorAll('li');
    processorList.addAll(PartsListSearchParameter.takeOutParameters(afterProcessorElement));

    return processorList;
  }

  static List<PartsSearchParameter> _parseSeriesList() {
    List<PartsSearchParameter> seriesList = [];

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
    seriesList.addAll(PartsListSearchParameter.takeOutParameters(seriesElement));
    return seriesList;
  }

  static List<PartsSearchParameter> _parseSocketList() {
    List<PartsSearchParameter> socketList = [];
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

    // ソケット情報は先頭5件がデフォルトで表示されており、それ以降は「もっと見る」を押すことで表示される

    // 先頭5件
    final firstSocketElement = openSocketElement[seriesNodeIndex].querySelectorAll('li');
    socketList.addAll(PartsListSearchParameter.takeOutParameters(firstSocketElement));

    //それ以降
    final afterSocketElement = openSocketElement[seriesNodeIndex + 1].querySelectorAll('li');
    socketList.addAll(PartsListSearchParameter.takeOutParameters(afterSocketElement));

    return socketList;
  }
}
