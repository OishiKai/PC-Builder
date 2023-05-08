
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/graphics_card_search_parameter.dart';
import '../document_repository.dart';
import '../parts_list_search_parameter.dart';

class GraphicsCardSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/videocard/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;
  
  static Future<GraphicsCardSearchParameter?> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final nvidiaChips = _parseNvidiaChipList();
    final amdChips = _parseAmdChips();
    return GraphicsCardSearchParameter(nvidiaChips, amdChips);
  }

  static List<PartsSearchParameter> _parseNvidiaChipList() {
    List<PartsSearchParameter> nvidiaChipList = [];
    // NVIDIAチップのリストは3番目の div にある

    // fetchSearchParameter() で _document に値が入っていることを保証しているので、nullチェックは不要
    final nvidiaChipListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul');
    
    // NVIDIAチップのリストは1番目と2番目 div にある
    final headNvidiaChipList = nvidiaChipListElement[0].querySelectorAll('li');
    final tailNvidiaChipList = nvidiaChipListElement[1].querySelectorAll('li');

    nvidiaChipList.addAll(PartsListSearchParameter.takeOutParameters(headNvidiaChipList));
    nvidiaChipList.addAll(PartsListSearchParameter.takeOutParameters(tailNvidiaChipList));

    return nvidiaChipList;
  }

  static List<PartsSearchParameter> _parseAmdChips() {
    List<PartsSearchParameter> amdChipList = [];
    // AMDチップのリストは3番目の div にある
    final amdChipListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul');
    
    // AMDチップのリストは3番目と4番目 div にある
    final headAmdChipList = amdChipListElement[2].querySelectorAll('li');
    final tailAmdChipList = amdChipListElement[3].querySelectorAll('li');

    amdChipList.addAll(PartsListSearchParameter.takeOutParameters(headAmdChipList));
    amdChipList.addAll(PartsListSearchParameter.takeOutParameters(tailAmdChipList));

    return amdChipList;
  }
}