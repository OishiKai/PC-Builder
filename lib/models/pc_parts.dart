import 'package:freezed_annotation/freezed_annotation.dart';

import 'parts_category.dart';
import 'parts_shop.dart';

part 'pc_parts.freezed.dart';

@freezed
class PcParts with _$PcParts {
  const factory PcParts({
    required PartsCategory category,
    required String id,
    required String maker,
    required bool isNew,
    required String title,
    required int? star,
    required String? evaluation,
    required String price,
    required String ranked,
    required String image,
    required String detailUrl,
    List<String>? fullScaleImages,
    Map<String, String?>? specs,
    List<PartsShop>? shops,
  }) = _PcParts;
}
