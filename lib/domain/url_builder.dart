import '../models/pc_parts.dart';

class UrlBuilder {
  static String standardPartsList(Category category) {
    String url =
        'https://kakaku.com/search_results/?category=0001%${category.categoryParameter}';
    return url;
  }

  static String searchPartsList(Category category, String searchText) {
    final encodedString = Uri.encodeFull(searchText);
    final url =
        'https://kakaku.com/search_results/$encodedString/?category=0001%${category.categoryParameter}';
    return url;
  }
}
