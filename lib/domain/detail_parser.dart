import 'package:custom_pc/domain/base_parser.dart';
import 'package:custom_pc/models/pc_parts_detail.dart';
import 'package:html/dom.dart';
import '../models/pc_parts.dart';
class DetailParser extends BaseParser {
  static const _fullScaleImageSelector = '#main > div.alignC > div > table > tbody > tr > td > a > img';
  static const _fullScaleFirstImageSelector = '#main > div.alignC > div > table > tbody > tr > td > img';

  PcParts targetParts;
  Document? document;
  List<String> fullScaleImages = [];

  DetailParser._(this.targetParts);

  static Future<DetailParser> create(PcParts parts) async {
    final self = DetailParser._(parts);
    self.fullScaleImages = (await self._getFullScaleImageUrls(parts.detailUrl))!;
    self.document = await self.fetchDocument(parts.detailUrl);
    return self;
  }

  Future<List<String>?> _getFullScaleImageUrls(String detailUrl) async {
    List<String> imageUrls = [];
    final baseImageUrl = detailUrl.replaceFirst('?lid=pc_ksearch_kakakuitem', 'images/');
    final multiImageUrl = '${baseImageUrl}page=ka_';
    int ite = 0;

    while (true) {
      //　1枚目だけURLが異なる為分岐
      if (ite == 0) {

        final firstImageDoc = await fetchDocument(baseImageUrl);
        List<Element> firstImage = firstImageDoc.querySelectorAll(_fullScaleFirstImageSelector);

        if (firstImage.isEmpty) {
          firstImage = firstImageDoc.querySelectorAll(_fullScaleImageSelector);
          if (firstImage.isEmpty) { return null; }
        }

        imageUrls.add(firstImage[0].attributes['src']!);
        ite += 1;
        continue;
      }

      final imageDoc = await fetchDocument('$multiImageUrl$ite');
      final image = imageDoc.querySelectorAll(_fullScaleImageSelector);
      ite += 1;

      if (image.isEmpty) { break; }
      imageUrls.add(image[0].attributes['src']!);
    }

    imageUrls.forEach((element) {
      print(element);
    });
    return imageUrls;
  }



}
