
import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

import '../../models/search_parameters/graphics_card_search_parameter.dart';
import '../document_repository.dart';

class GraphicsCardSearchParameterParser {
  static const String standardPage = 'https://kakaku.com/pc/videocard/itemlist.aspx';
  static const String _parameterSelector = '#menu > div.searchspec > div';

  static Document? _document;
  
  static Future<GraphicsCardSearchParameter?> fetchSearchParameter() async {
    _document = await DocumentRepository.fetchDocument(standardPage);
    final nvidiaChips = _parseNvidiaChipList()!;
    final amdChips = _parseAmdChips()!;
    return GraphicsCardSearchParameter(nvidiaChips, amdChips);
  }

  static List<PartsSearchParameter>? _parseNvidiaChipList() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> nvidiaChipList = [];
    // NVIDIAチップのリストは3番目の div にある
    final nvidiaChipListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul');
    
    // NVIDIAチップのリストは1番目と2番目 div にある
    final headNvidiaChipList = nvidiaChipListElement[0].querySelectorAll('li');
    final tailNvidiaChipList = nvidiaChipListElement[1].querySelectorAll('li');

    headNvidiaChipList.forEach((element) { 
      final nvidiaChipName = element.text.split('（')[0];
      final nvidiaChipParameterAtag = element.querySelectorAll('a');
      if (nvidiaChipParameterAtag.isNotEmpty) {
        final nvidiaChipParameter = nvidiaChipParameterAtag[0].attributes['href']!.split('?')[1];
        nvidiaChipList.add(PartsSearchParameter(nvidiaChipName, nvidiaChipParameter));
      } 
    });
    
    tailNvidiaChipList.forEach((element) { 
      final nvidiaChipName = element.text.split('（')[0];
      final nvidiaChipParameterAtag = element.querySelectorAll('a');
      if (nvidiaChipParameterAtag.isNotEmpty) {
        final nvidiaChipParameter = nvidiaChipParameterAtag[0].attributes['href']!.split('?')[1];
        nvidiaChipList.add(PartsSearchParameter(nvidiaChipName, nvidiaChipParameter));
      } 
    });
    return nvidiaChipList;
  }

  static List<PartsSearchParameter>? _parseAmdChips() {
    if (_document == null) {
      return null;
    }
    List<PartsSearchParameter> amdChipList = [];
    // AMDチップのリストは3番目の div にある
    final amdChipListElement = _document!.querySelectorAll(_parameterSelector)[4].querySelectorAll('ul');
    
    // AMDチップのリストは3番目と4番目 div にある
    final headAmdChipList = amdChipListElement[2].querySelectorAll('li');
    final tailAmdChipList = amdChipListElement[3].querySelectorAll('li');

    headAmdChipList.forEach((element) { 
      final amdChipName = element.text.split('（')[0];
      final amdChipParameterAtag = element.querySelectorAll('a');
      if (amdChipParameterAtag.isNotEmpty) {
        final amdChipParameter = amdChipParameterAtag[0].attributes['href']!.split('?')[1];
        amdChipList.add(PartsSearchParameter(amdChipName, amdChipParameter));
      } 
    });
    
    tailAmdChipList.forEach((element) { 
      final amdChipName = element.text.split('（')[0];
      final amdChipParameterAtag = element.querySelectorAll('a');
      if (amdChipParameterAtag.isNotEmpty) {
        final amdChipParameter = amdChipParameterAtag[0].attributes['href']!.split('?')[1];
        amdChipList.add(PartsSearchParameter(amdChipName, amdChipParameter));
      } 
    });
    return amdChipList;
  }
}