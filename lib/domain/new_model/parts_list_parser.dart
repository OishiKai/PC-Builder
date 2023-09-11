import 'package:custom_pc/models/parts_category.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:html/dom.dart';

import '../document_repository.dart';

class PartsListParserNM {
  static const _partsListSelector = '#compTblList > tbody > tr.tr-border';
  static const _partsMakerSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > a > span';
  static const _partsCombinedMakerAndTitleSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > a';
  static const _partsNewSelector = 'td.end.checkItem > table > tbody > tr > td.ckitemLink > img';
  static const _partsImageUrlSelector = 'td.alignC > a > img';
  static const _partsDetailUrlSelector = 'td.alignC > a';
  static const _partsPriceSelector = 'td.td-price > ul > li.pryen > a';
  static const _patsRankedSelector = 'td.swrank2 > span';

  static Future<List<PcParts>> fetch(String url) async {
    final document = await DocumentRepository.fetchDocument(url);
    final partsList = _parsePartsList(document, url);
    return partsList;
  }

  static List<PcParts> _parsePartsList(Document document, String url) {
    final List<PcParts> partsList = [];
    final partsListElement = document.querySelectorAll(_partsListSelector);
    final category = PartsCategory.fromCategoryParameter(url.split('pc/')[1].split('/itemlist')[0]);

    for (int i = 1; i < partsListElement.length; i += 3) {
      final maker = partsListElement[i].querySelectorAll(_partsMakerSelector)[0].text;
      // 商品名を直接取得できず、"{メーカー名} {商品名}"という形式で取得し、"{メーカー名} "を除く
      final combined = partsListElement[i].querySelectorAll(_partsCombinedMakerAndTitleSelector)[0].text;
      final title = combined.replaceFirst(maker, '');
      final isNew = partsListElement[i].querySelectorAll(_partsNewSelector).isNotEmpty;
      var imageUrl = partsListElement[i + 1].querySelectorAll(_partsImageUrlSelector)[0].attributes['src']!.replaceFirst('/m/', '/ll/');

      final id = partsListElement[i + 1].querySelectorAll(_partsDetailUrlSelector)[0].attributes['href']!.split('/item/')[1].replaceAll('/', '');
      final price = partsListElement[i + 1].querySelectorAll(_partsPriceSelector)[0].text;
      final ranked = partsListElement[i + 1].querySelectorAll(_patsRankedSelector)[0].text;

      // レビュー、評価数はセレクターでうまくパースできなかった為、改行ごとに区切って6つ目の要素を取得する
      // evaluate は 取得時 "4.95(15件)" という形式なので、"件"を除く
      var evaluation = '';
      var strStar = '';

      // 4つ目の要素に入っている場合もあったので、分岐して対応
      final evas = partsListElement[i + 1].text.split('\n');
      if (evas[5].contains('件')) {
        evaluation = evas[5].replaceAll('件', '');
      } else {
        final evaluations = evas[3].split('位');
        evaluation = evaluations[evaluations.length - 1].replaceAll('件', '');
      }
      strStar = evaluation.split('(')[0];

      int? star;
      if (strStar != '—') {
        // "4.95" -> "49" に変換
        if (double.tryParse(strStar) != null) {
          final doubleStar = double.parse(strStar);
          star = doubleStar * 100 ~/ 10;
        }
      }
      partsList.add(PcParts(
        id: id,
        category: category,
        maker: maker,
        isNew: isNew,
        title: title,
        star: star,
        evaluation: evaluation,
        price: price,
        ranked: ranked,
        image: imageUrl,
      ));
    }
    return partsList;
  }
}
