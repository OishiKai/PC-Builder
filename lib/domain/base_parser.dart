import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:charset_converter/charset_converter.dart';

abstract class BaseParser {
   Future<Document> fetchDocument(String url) async {
    final targetUri = Uri.parse(url);
    final response = await http.get(targetUri);

    // response を Shift_JIS にデコード
    final documenBody = await CharsetConverter.decode('Shift_JIS', response.bodyBytes);

    // パース
    final document = parse(documenBody);
    return document;
  }
}