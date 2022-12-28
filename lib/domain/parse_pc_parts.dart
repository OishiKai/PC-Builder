import 'package:http/http.dart' as http;
import 'package:charset_converter/charset_converter.dart';

abstract class BaseParser {
   static Future<dynamic> _fetchDocument(String url) async {
    final targetUri = Uri.parse(url);
    final response = await http.get(targetUri);
    // response を Shift_JIS にデコード
    final document = await CharsetConverter.decode('Shift_JIS', response.bodyBytes);
    return document;
  }
}