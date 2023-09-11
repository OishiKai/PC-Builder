import 'package:custom_pc/domain/new_model/parts_list_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('new model fetch parts list', () async {
    final list = await PartsListParserNM.fetch('https://kakaku.com/pc/videocard/itemlist.aspx');
    expect(list.length, 40);
  });
}
