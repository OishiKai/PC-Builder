import 'package:html/dom.dart';

import '../../models/category_home_data.dart';
import '../../models/pc_parts.dart';
import '../document_repository.dart';

class MotherBoardHomeParser {
  // パース対象のURL
  static const _pageUrl = 'https://kakaku.com/pc/motherboard/';

  // intelソケット情報
  static const _socketIntelSelector = '#menu > div:nth-child(21) > div > div:nth-child(9) > ul > li';

  // intelソケット情報
  static const _socketAmdSelector = '#menu > div:nth-child(21) > div > div:nth-child(11) > ul > li';

  // 売れ筋ランキングのリスト
  static const _popularPartsListSelector = '#ct087 > div.contMain > div.contMainIn > ol > li';

  // 売れ筋ランキングのパーツの画像
  static const _partsImageSelector = 'div > div.itemImg > img';

  // 売れ筋ランキングのメーカー名
  static const _makerSelector = 'div > div.itemIn2 > p.makerName';

  // 売れ筋ランキングの商品名
  static const _titleSelector = 'div > div.itemIn2 > p:nth-child(3)';

  // 売れ筋ランキングの価格
  static const _priceSelector = 'div > div.itemIn3 > p.itemPrice';

  // 売れ筋ランキングの星の数 "5.00" のような形式
  static const _starSelector = 'div > div.itemIn3 > p.starRate > span.num1';

  // 売れ筋ランキングの評価数 "（2人）"のような形式
  static const _evaluationSelector = 'div > div.itemIn3 > p.starRate > span.num2';

  // 詳細画面へのURL
  static const _detailUrlSelector = 'div > div.itemIn2 > p:nth-child(3) > a';

  // 検索ホーム画面での人気製品の表示数　偶数にすべし
  static const _popularPartsRequired = 8;

  static Document? _document;
  static Future<MotherBoardHome?> fetchAndParse() async {
    _document = await DocumentRepository.fetchDocument(_pageUrl);
    final intelSockets = _parseIntelSockets()!;
    final amdSockets = _parseAmdSockets()!;
    final parts = _parsePopularPats()!;

    // 同メソッド内で _document に代入している為、ここのnullは握りつぶす
    return MotherBoardHome(intelSockets, amdSockets, parts);
  }

  static List<String>? _parseIntelSockets() {
    if (_document == null) {
      return null;
    }

    final List<String> sockets = [];
    final partsListElement = _document!.querySelectorAll(_socketIntelSelector);
    for (var element in partsListElement) {
      sockets.add(element.text.split('(')[0]);
    }
    return sockets;
  }

  static List<String>? _parseAmdSockets() {
    if (_document == null) {
      return null;
    }

    final List<String> sockets = [];
    final partsListElement = _document!.querySelectorAll(_socketAmdSelector);
    for (var element in partsListElement) {
      print(element.text.split('(')[0]);
      sockets.add(element.text.split('(')[0]);
    }
    return sockets;
  }

  static List<PcParts>? _parsePopularPats() {
    if (_document == null) {
      return null;
    }
    List<PcParts> partsList = [];
    final partsListElement = _document!.querySelectorAll(_popularPartsListSelector);

    for (int i = 0; i < _popularPartsRequired; i++) {
      final element = partsListElement[i];
      final imageUrl = element.querySelectorAll(_partsImageSelector)[0].attributes['data-src'];
      final maker = element.querySelectorAll(_makerSelector)[0].text;
      final title = element.querySelectorAll(_titleSelector)[0].text;
      final price = element.querySelectorAll(_priceSelector)[0].text;

      // 取得時の形式は "4.95" のようなかたち　PcPartsオブジェクトに渡す際は　"49"のようなかたちにする
      final tempStar = element.querySelectorAll(_starSelector)[0].text;

      // 取得時の形式は "（2人）"のようなかたち　PcPartsオブジェクトには "4.95(5)" のようなかたちで渡す為、tempStarと組み合わせる
      final evaluation = '$tempStar${element.querySelectorAll(_evaluationSelector)[0].text.replaceFirst('人', '').replaceFirst('（', '(').replaceFirst('）', ')')}';

      // 取得時、末尾に "?lid=20190108pricemenu_ranking_1" のようなパラメータがつくので除き、PartsListPageでの取得時の形式に整形する
      final detailUrl = '${element.querySelectorAll(_detailUrlSelector)[0].attributes['href']!.split('?lid')[0]}?lid=pc_ksearch_kakakuitem';

      int? star;
      if (tempStar != '—') {
        // "4.95" -> "49" に変換
        if (double.tryParse(tempStar) != null) {
          final doubleStar = double.parse(tempStar);
          star = doubleStar * 100 ~/ 10;
        }
      }

      partsList.add(PcParts(maker, false, title, star, evaluation, price, '$i', imageUrl!, detailUrl!));
    }

    return partsList;
  }
}
