import 'package:freezed_annotation/freezed_annotation.dart';
import 'parts_shop.dart';

part 'pc_parts.freezed.dart';

@freezed
class PcParts with _$PcParts {
  const factory PcParts({
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

enum PartsCategory {
  cpu('CPU', 'CPU','cpu'),
  cpuCooler('CPUクーラー', 'CPUクーラ','2C0030'),
  memory('メモリー', 'メモリ','2C0033'),
  motherBoard('マザーボード', 'マザボ','2C0036'),
  graphicsCard('グラフィックボード・ビデオカード', 'グラボ','2C0028'),
  ssd('SSD', 'SSD','2C0070'),
  pcCase('PCケース', 'ケース','2C0032'),
  powerUnit('電源ユニット', '電源','2C0035'),
  caseFan('ケースファン', 'ケースファン','2C0089');

  final String categoryName;
  final String categoryShortName;
  final String categoryParameter;
  const PartsCategory(this.categoryName, this.categoryShortName, this.categoryParameter);
}
