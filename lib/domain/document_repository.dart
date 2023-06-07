import 'package:charset_converter/charset_converter.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class DocumentRepository {
  static Future<Document> fetchDocument(String targetUrl) async {
    // HTTP GETリクエスト送信
    final targetUri = Uri.parse(targetUrl);
    final response = await http.get(targetUri);

    // response を Shift_JIS にデコード
    final documentBody = await CharsetConverter.decode('Shift_JIS', response.bodyBytes);

    // パース
    final document = parse(documentBody);
    return document;
  }
}
