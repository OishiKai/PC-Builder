import 'package:custom_pc/domain/document_repository.dart';
import 'package:custom_pc/models/parts_shop.dart';
import 'package:html/dom.dart';
import '../models/pc_parts.dart';
class DetailParser {
  static const _fullScaleImageSelector = '#main > div.alignC > div > table > tbody > tr > td > a > img';
  static const _fullScaleFirstImageSelector = '#main > div.alignC > div > table > tbody > tr > td > img';

  // 店舗情報のリスト
  static const _partsShopListSelector = '#mainLeft > table > tbody > tr';

  // 店舗の価格ランキング
  static const _partsShopRankSelector = 'td:nth-child(1) > span';

  // 店舗の販売価格
  static const _partsShopPriceSelector = 'td.p-priceTable_col.p-priceTable_col-priceBG > div > p.p-PTPrice_price';

  /*
  最安値と店舗の販売価格の差
  最安値で販売している場合は '(最安)'と取得される
   */
  static const _partsShopBestPriceDiffSelector = 'td.p-priceTable_col.p-priceTable_col-priceBG > div > p.p-PTPrice_sub';

  // 店舗名
  static const _partsShopNameSelector = 'td.p-priceTable_col.p-priceTable_col-shopInfo > div.p-PTShop > div.p-PTShop_info > div > p.p-PTShopData_name > a';

  // 店舗の販売ページ
  static const _partsShopPageUrlSelector = 'td.p-priceTable_col.p-priceTable_col-shopInfo > div.p-PTShop > div.p-PTShop_btn > a';

  // パーツのスペックテーブル行
  static const _partsSpecLineSelector = '#mainLeft > table > tbody > tr';

  PcParts targetParts;
  Document? document;
  List<String> fullScaleImages = [];
  List<PartsShop> partsShops = [];
  Map<String, String?>? specs = {};
  /*
  コンストラクタをプライベートとし、createでオブジェクトを生成。
  オブジェクト生成時に該当ページのDocumentのフェッチ、パースを完了させる。
   */
  DetailParser._(this.targetParts);
  static Future<DetailParser> create(PcParts parts) async {
    final self = DetailParser._(parts);
    self.fullScaleImages = (await self._getFullScaleImageUrls(parts.detailUrl))!;
    self.document = await DocumentRepository.fetchDocument(parts.detailUrl);
    self.partsShops = self._getPartsShops(self.document!);
    self.specs = await self._getSpecs(parts.detailUrl);
    return self;
  }


  Future<List<String>?> _getFullScaleImageUrls(String detailUrl) async {
    List<String> imageUrls = [];
    final baseImageUrl = detailUrl.replaceFirst('?lid=pc_ksearch_kakakuitem', 'images/');
    final multiImageUrl = '${baseImageUrl}page=ka_';
    int imageCount = 0;

    while (true) {
      //　1枚目だけURLが異なる為分岐
      if (imageCount == 0) {

        final firstImageDoc = await DocumentRepository.fetchDocument(baseImageUrl);
        List<Element> firstImage = firstImageDoc.querySelectorAll(_fullScaleFirstImageSelector);

        if (firstImage.isEmpty) {
          firstImage = firstImageDoc.querySelectorAll(_fullScaleImageSelector);
          if (firstImage.isEmpty) { return null; }
        }

        imageUrls.add(firstImage[0].attributes['src']!);
        imageCount += 1;
        continue;
      }

      final imageDoc = await DocumentRepository.fetchDocument('$multiImageUrl$imageCount');
      final image = imageDoc.querySelectorAll(_fullScaleImageSelector);
      imageCount += 1;

      if (image.isEmpty) { break; }
      imageUrls.add(image[0].attributes['src']!);
    }

    imageUrls.forEach((element) {
      print(element);
    });
    return imageUrls;
  }

  List<PartsShop> _getPartsShops(Document doc) {
    List<PartsShop> partsShopList = [];
    final listElements = doc.querySelectorAll(_partsShopListSelector);
    // 販売店がない場合
    if (listElements.isEmpty) { return partsShopList; }

    /*
    販売店が1件以上ある場合、listElements.length は 店舗数+2 となる。
    先頭2つのノードが店舗情報ではない為、3つめのノードからパースを行う。
    また、販売店が11件以上ある場合は10件おきに2つの店舗情報ではないノードが入る為、adjustIndexでパース対象を調整する。
     */
    final numberOfNode = listElements.length;
    int parsedShopCount = 0;
    int adjustIndex = 2;
    while (true) {
      final shopNodeIndex = parsedShopCount + adjustIndex;
      final rank = listElements[shopNodeIndex].querySelectorAll(_partsShopRankSelector)[0].text;
      final price = listElements[shopNodeIndex].querySelectorAll(_partsShopPriceSelector)[0].text;
      final diff = listElements[shopNodeIndex].querySelectorAll(_partsShopBestPriceDiffSelector)[0].text;
      final shopName = listElements[shopNodeIndex].querySelectorAll(_partsShopNameSelector)[0].text;
      final shopPageUrl = listElements[shopNodeIndex].querySelectorAll(_partsShopPageUrlSelector)[0].attributes['href'];
      partsShopList.add(PartsShop(rank, price, diff, shopName, shopPageUrl!));
      parsedShopCount++;
      if ( parsedShopCount + adjustIndex == numberOfNode) { break; }
      // 販売店10件おきに2つ、店舗情報ではないノードが入る為、indexを調整
      if ( parsedShopCount % 10 == 0) {  adjustIndex += 2; }
    }
    return partsShopList;
  }

  Future<Map<String, String?>> _getSpecs(String url) async {
    Map<String, String?> specMap = {};
    final specUrl = url.replaceFirst('/?lid=pc_ksearch_kakakuitem', '/spec');
    final doc = await DocumentRepository.fetchDocument(specUrl);
    final specElements = doc.querySelectorAll(_partsSpecLineSelector);
    final elementLength = specElements.length;

    /*
    該当ページのスペックが記載されているテーブルは分類行とスペック行の二種で構成されている。
    分類行は分類名のみ取得し、スペック行はカテゴリー名とスペック名のペアを2回取得する。
    分類はkeyのみでvalueはnull、カテゴリー名はあるがスペック名がない場合はvalueは空文字で表現。
    */
    int classLineCount = 0;
    int specLineCount = 0;
    while (true) {
      final next = classLineCount + specLineCount;
      if (specElements[next].querySelectorAll('td').isEmpty) {
        // 分類行
        final cls = specElements[next].text.replaceFirst('\n', '');
        specMap[cls] = null;
        classLineCount++;
        continue;
      }

      // カテゴリー+スペック行
      for(int i = 0; i < 2; i++) {
        final category = specElements[next].querySelectorAll('th')[i].text;
        final spec = specElements[next].querySelectorAll('td')[i].text;
        specMap[category] = spec;
      }
      specLineCount++;

      if (classLineCount + specLineCount == elementLength) { break; }
    }
    return specMap;
  }
}
