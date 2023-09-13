import 'package:custom_pc/models/parts_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'parts_shop.dart';

part 'pc_parts.freezed.dart';

@freezed
class PcParts with _$PcParts {
  const PcParts._();

  const factory PcParts({
    required String id,
    required PartsCategory category,
    required String maker,
    required bool isNew,
    required String title,
    required int? star,
    required String? evaluation,
    required String price,
    required String ranked,
    required String image,
    int? fullScaleImageCount,
    Map<String, String?>? specs,
    List<PartsShop>? shops,
  }) = _PcParts;

  String getDetailUrl() {
    return 'https://kakaku.com/item/$id/';
  }

  List<String> getFullScaleImageUrls() {
    if (fullScaleImageCount == null) return [image];
    List<String> imageUrls = [];
    for (int i = 0; i < fullScaleImageCount!; i++) {
      if (i == 0) {
        imageUrls.add('https://kakaku.com/item/$id/images/');
      } else {
        imageUrls.add('https://kakaku.com/item/$id/images/page=ka_$i/');
      }
    }
    return imageUrls;
  }
}
