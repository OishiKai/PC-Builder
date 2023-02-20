import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:html/dom.dart';

class PartsListParser {
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

  final String targetUrl;
  Document? document;
  List<PcParts>? partsList;

  /*
  コンストラクタをプライベートとし、createでオブジェクトを生成。
  オブジェクト生成時に該当ページのDocumentのフェッチ、パースを完了させ、
  .partsListを参照してパーツリストを取り出す。
   */
  PartsListParser._(this.targetUrl);
  static Future<PartsListParser> create(String url) async {
     final self = PartsListParser._(url);
     self.document = await DocumentRepository.fetchDocument(url);
     self.partsList = self._parsePartsList();
     return self;
  }

  List<PcParts> _parsePartsList() {
    // オブジェクト生成時には必ずdocumentが入る為nullではない
    final elementList = document!.querySelectorAll(_listSelector);

    List<PcParts> partsList = [];
    for (var element in elementList) {
      // メーカ名取得
      final maker = element.querySelectorAll(_makerSelector)[0].text;
      // 商品名取得
      final title = element.querySelectorAll(_titleSelector)[0].text;

      // 新商品かどうか判定
      bool isNew = false;
      if (element.querySelectorAll(_newTitleSelector).isNotEmpty) {
        isNew = true;
      }

      // 星の数、評価数取得
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

      partsList.add(PcParts(maker,isNew,title,star,eva,price!,rank!,image,detailUrl!));
    }

    return partsList;
  }

  Map<String,dynamic>? _specificEvaluation(Element element) {
    int ratingSelector = 50;
    int? star;
    String? evaluation;

    /*
    評価(星の数)を特定、取得する。
    星の数は0~5の0.5刻み10段階であり、星5の場合は '$_starSelector50' というセレクターで評価数を取得できる。
    末尾の数字を50から5刻みで下げ、パース結果がヒットしたものを評価として採用。
    取得完了後は
    評価星3.5の場合 -> star = 35, evaluation = 3.5(1) という形式となる(かっこの数はレビュー数) 。
     */
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