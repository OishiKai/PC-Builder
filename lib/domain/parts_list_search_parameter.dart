import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:html/dom.dart';

class PartsListSearchParameter {

  /*
    HTMLDocumentから取り出したElementの配列から、
    検索条件名とパラメータを取り出す
    例) ['AMD', 'pdf_ma=7']
  */

  static List<PartsSearchParameter> takeOutParameters(List<Element> element) {
    // 末尾に（商品数）がついているので、削除してパラメータを取得する
    List<PartsSearchParameter> params = [];
    for (var elem in element) {
      final makerName = elem.text.split('（')[0];
      // パラメータは <a> か <span> に入っている
      if (elem.querySelectorAll('a').isNotEmpty) {
        final makerParameter = elem.querySelectorAll('a')[0].attributes['href']!.split('?')[1];
        params.add(PartsSearchParameter(makerName, makerParameter));
      } else if (elem.querySelectorAll('span').isNotEmpty) {
        // <span> に入っている場合は onclick 内のパラメータが "changeLocation(欲しいパラメータ)" となっている
        final makerParameter = elem.querySelectorAll('span')[0].attributes['onclick']!;
        final split = makerParameter.split("changeLocation('")[1].split("');")[0];
        params.add(PartsSearchParameter(makerName, split));
      }
    }
    return params;
  }
}