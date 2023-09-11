import 'package:custom_pc/models/parts_category.dart';
import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom.freezed.dart';

@freezed
class Custom with _$Custom {
  const Custom._();

  const factory Custom({
    String? id,
    // Custom名
    String? name,
    // 総額
    String? totalPrice,
    // 各パーツ
    required List<PcParts> parts,
    // 保存日
    String? date,
    // 互換性のリスト
    List<PartsCompatibility>? compatibilities,
  }) = _Custom;

  List<PcParts> get(PartsCategory category) {
    return parts.where((element) => element.category == category).toList();
  }

  int partsCount(PartsCategory category) {
    return parts.where((element) => element.category == category).length;
  }

  int calcTotalPrice() {
    int totalPrice = 0;
    for (var part in parts) {
      totalPrice += int.parse(part.price.replaceAll(',', ''));
    }
    return totalPrice;
  }

  String formatTotalPrice() {
    final String stringValue = calcTotalPrice().toString();
    final StringBuffer buffer = StringBuffer();

    buffer.write('¥');

    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }

    return buffer.toString();
  }

  String getMainImage(PartsCategory category) {
    final List<PcParts> parts = get(category);
    // 最も値段の高いパーツを返す
    final exParts = parts.reduce((a, b) => parsePrice(a.price) > parsePrice(b.price) ? a : b);
    return exParts.image;
  }

  int parsePrice(String price) {
    final normalizedPrice = price.trim().replaceAll('¥', '').replaceAll(',', '');
    return normalizedPrice.isEmpty ? 0 : int.parse(normalizedPrice);
  }
}
