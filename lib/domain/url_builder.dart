import 'package:euc/jis.dart';

import '../models/pc_parts.dart';

class UrlBuilder {
  static String standardPartsList(Category category) {
    String url = 'https://kakaku.com/search_results/?category=0001%${category.categoryParameter}';
    return url;
  }

  static String searchPartsList(Category category, String searchText) {
    final percent = Uri.encodeQueryComponent(searchText, encoding: ShiftJIS());
    final url = 'https://kakaku.com/search_results/$percent/?category=0001%${category.categoryParameter}';
    return url;
  }

  static String buildSearchUrl(Category category, String parameter) {
    final url = 'https://kakaku.com/pc/${category.categoryParameter}/itemlist.aspx?${parameter}';
    return url;
  }
}
 