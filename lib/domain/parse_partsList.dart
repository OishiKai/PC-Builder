import 'package:custom_pc/domain/base_parser.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:html/dom.dart';

class PartsListParser extends BaseParser {
  // 商品のリスト化
  static const _listSelector = '#default > div.l-c.l-c-2column.l-c-2column-reverse > div.l-c_cont.l-c-2column_cont.p-cont.p-cont-wide > div > div.p-result_list_wrap > div > div';
  // メーカー名
  static const _makerSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > div > p.p-item_maker';

  /*
  商品名
  新商品の場合のみ_newTitleSelectorでも商品名を取得できる為、新商品かどうかの判定に利用する
   */
  static const _titleSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > div > p.p-item_name.s-biggerlinkHover_underline';
  static const _newTitleSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > div > p.p-item_name.s-biggerlinkHover_underline.c-box-menuBox_new';

  /*
  評価(星の数)
  末尾の'p-item_star-'の後に数字を加えて利用する
  星5評価の場合 'p-item_star-50', 星3.5評価の場合'p-item_star-35'と5刻みでクラス分けされている
  商品が評価されている場合、評価の数値とレビュー数(例: 5.00(1))が取得でき、評価されていない場合、取得に失敗する
   */
  static const _starSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > div > div.p-item_rate > p.p-item_star.p-item_star-';

  // 価格
  static const _priceSelector = 'div.c-positioning_cell.p-result_item_cell-2 > div > p.p-item_price > span';

  // 順位 圏外の場合'-'
  static const _rankSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > div > div.p-item_rate > p.p-item_rank > span';

  /*
  商品画像URL
  imgタグごと取得してしまう為、不要な部分を除く必要あり
   */
  static const _imageUrlSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > p > a > noscript';

  // 詳細ページURL
  static const _detailUrlSelector = 'div.c-positioning_cell.p-result_item_cell-1 > div.c-positioning.s-biggerlink.is-biggerlinkHot.p-item > p > a';

  final String tergetUrl;

  PartsListParser(this.tergetUrl);

  Future<List<Pcparts>> setUpViews() async {
    final document = await super.fetchDocument(tergetUrl);
    final elementList = document.querySelectorAll(_listSelector);

    List<Pcparts> partsList = [];
    for (var element in elementList) {
      final maker = element.querySelectorAll(_makerSelector)[0].text;

      final title = element.querySelectorAll(_titleSelector)[0].text;

      bool isNew = false;
      if (element.querySelectorAll(_newTitleSelector).isNotEmpty) {
        isNew = true;
      }

      int? star;
      String? eva;
      Map<String,dynamic>? specified = _specificEvaluation(element);
      if (specified != null) {
        star = specified['star'];
        eva = specified['evaluation'];
      }

      final price = element.querySelectorAll(_priceSelector)[0].text;
      final rank = element.querySelectorAll(_rankSelector)[0].text;
      final image = _trimImageUrl(element.querySelectorAll(_imageUrlSelector)[0].text);
      final detailUrl = element.querySelectorAll(_detailUrlSelector)[0].attributes['href'];

      partsList.add(Pcparts(maker,isNew,title,star,eva,price!,rank!,image,detailUrl!));
    }

    print(partsList.length);
    partsList.forEach((element) {
      print(element.detailUrl);
    });

    return partsList;
  }

  Map<String,dynamic>? _specificEvaluation(Element element) {
    int ratingSelector = 50;
    int? star;
    String? evaluation;

    while (ratingSelector != 0) {
      final parsed = element.querySelectorAll('$_starSelector$ratingSelector');

      if (parsed.isNotEmpty) {
        star = ratingSelector;
        evaluation = parsed[0].text;
        break;
      }

      ratingSelector -= 5;
    }

    if (star == null && evaluation == null) { return null; }
    
    return {'star':star, 'evaluation':evaluation!.trim()};
  }

  String _trimImageUrl(String target) {
    String trim = target.trim();
    String replaced = trim.replaceFirst('<img src="', '');
    String url = replaced.split('"').first;
    return url;
  }
}