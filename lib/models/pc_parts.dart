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
  cpu('CPU', 'CPU', 'cpu'),
  cpuCooler('CPUクーラー', 'CPUクーラー', 'cpu-cooler'),
  memory('メモリー', 'メモリ', 'pc-memory'),
  motherboard('マザーボード', 'マザーボード', 'motherboard'),
  graphicsCard('グラフィックボード・ビデオカード', 'グラフィックボード', 'videocard'),
  ssd('SSD', 'SSD', 'ssd'),
  pcCase('PCケース', 'ケース', 'pc-case'),
  powerUnit('電源ユニット', '電源', 'power-supply'),
  caseFan('ケースファン', 'ケースファン', 'case-fan');

  final String categoryName;
  final String categoryShortName;
  final String categoryParameter;
  const PartsCategory(this.categoryName, this.categoryShortName, this.categoryParameter);

  String basePartsListUrl() {
    return 'https://kakaku.com/pc/$categoryParameter/itemlist.aspx';
  }

  static PartsCategory fromCategoryName(String categoryName) {
    switch (categoryName) {
      case 'CPU':
        return PartsCategory.cpu;
      case 'CPUクーラー':
        return PartsCategory.cpuCooler;
      case 'メモリー':
        return PartsCategory.memory;
      case 'マザーボード':
        return PartsCategory.motherboard;
      case 'グラフィックボード・ビデオカード':
        return PartsCategory.graphicsCard;
      case 'SSD':
        return PartsCategory.ssd;
      case 'PCケース':
        return PartsCategory.pcCase;
      case '電源ユニット':
        return PartsCategory.powerUnit;
      case 'ケースファン':
        return PartsCategory.caseFan;
      default:
        throw Exception('PartsCategory.fromCategoryName: $categoryName is not found.');
    }
  }
}
