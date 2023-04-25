import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/category_home_data.dart';
import 'package:html/dom.dart';

class GraphicsCardHomeParser {
  static const _pageUrl = 'https://kakaku.com/pc/videocard/?lid=pc_ksearch_relatedpage';
  static const _nvidiaChipListSelector = '#menu > div:nth-child(24) > div > div:nth-child(3) > ul:nth-child(3) > li';
  static const _amdChipListSelector = '#menu > div:nth-child(24) > div > div:nth-child(5) > ul:nth-child(3) > li';

  static Document? _document;
  static Future<GraphicsCardHome?> fetchAndParse() async {
    _document = await DocumentRepository.fetchDocument(_pageUrl);
    _parseNvidiaChips();
    _parseAmdChips();
    return null;
  }

  static List<String>? _parseNvidiaChips() {
    if (_document == null) {
      return null;
    }
    List<String> chips = [];
    final menu = _document!.querySelectorAll(_nvidiaChipListSelector);
    for (var element in menu) {
      chips.add(element.text.split('(')[0]);
    }
    return chips;
  }

  static List<String>? _parseAmdChips() {
    if (_document == null) {
      return null;
    }
    List<String> chips = [];
    final menu = _document!.querySelectorAll(_amdChipListSelector);
    for (var element in menu) {
      chips.add(element.text.split('(')[0]);
    }
    return chips;
  }
}
