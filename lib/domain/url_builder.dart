import 'package:euc/jis.dart';

import '../models/parts_category.dart';

class UrlBuilder {
  static String standardPartsList(PartsCategory category) {
    String url = 'https://kakaku.com/search_results/?category=0001%${category.categoryParameter}';
    return url;
  }

  static String searchPartsList(PartsCategory category, String searchText) {
    final percent = Uri.encodeQueryComponent(searchText, encoding: ShiftJIS());
    final url = 'https://kakaku.com/search_results/$percent/?category=0001%${category.categoryParameter}';
    return url;
  }

  static String buildSearchUrl(PartsCategory category, String parameter) {
    final url = 'https://kakaku.com/pc/${category.categoryParameter}/itemlist.aspx?${parameter}';
    return url;
  }

  /*
  検索ページのURLの末尾にパラメータを付加し、絞り込み検索を行う。
  パラメータは "pdf_{文字列}={数字}"で渡される。
  複数のパラメータが渡された場合、文字列部分を比較してパラメータをまとめる
  ・複数のパラメータの文字列部分が同じ場合  → "pdf_{文字列}={数字A},{数字B}"
  ・複数のパラメータの文字列部分が異なる場合 → "pdf_{文字列A}={数字A}&pdf_{文字列B}={数字B}"
   */
  static String createURLWithParameters(String baseURL, List<String> parameters) {
    StringBuffer urlBuffer = StringBuffer(baseURL);
    // パラメーターが渡されている
    if (parameters.isNotEmpty) {
      urlBuffer.write('?');

      Map<String, List<String>> parameterMap = {};

      //Mapで文字列部分ごとに数字部分をまとめる
      //例）{abc: [100, 200], def: [100, 300]}
      for (String parameter in parameters) {
        List<String> parts = parameter.split('=');
        if (parts.length == 2) {
          // 文字列部分
          String key = parts[0].split('_')[1];
          // 数字部分
          String value = parts[1];

          parameterMap.putIfAbsent(key, () => []).add(value);
        }
      }
      List<String> parameterStrings = [];

      // 同じ文字列部分のパラメータを','区切りでまとめる
      parameterMap.forEach((key, values) {
        String parameterString = 'pdf_$key=';
        if (values.length > 1) {
          // 文字列部分が共通のパラメータが複数ある場合
          parameterString += values.join(',');
        } else {
          // 文字列部分が共通のパラメータがない場合
          parameterString += values.first;
        }
        // parameterString = 'pdf_abc=100,200'
        parameterStrings.add(parameterString);
      });
      // 文字列部分ごとにまとめたパラメータを'&'で区切る
      urlBuffer.write(parameterStrings.join('&'));
    }

    // PCケースの色を指定する場合、&pdf_co=0 を末尾に付加する
    var url = urlBuffer.toString();
    if (urlBuffer.toString().contains('Spec121')) {
      url = url += '&pdf_co=0';
    }

    return url;
  }

  //static String createUrlWit
}
