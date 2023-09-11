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
    required int fullScaleImageCount,
    Map<String, String?>? specs,
    List<PartsShop>? shops,
  }) = _PcParts;
}
