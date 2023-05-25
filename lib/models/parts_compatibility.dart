import 'package:custom_pc/models/pc_parts.dart';

class PartsCompatibility {
  // 互換性を検証するパーツのペア
  final List<PartsCategory> pair;
  // { "互換性を検証する項目(ソケット形状 など)": true(互換性あり), false(互換性なし), null(判定不可)}
  Map<String, bool?> isCompatible;
  // パーツの画像のURL Widget表示の為に持たせる
  final List<String> urls;
  PartsCompatibility(this.pair, this.urls, {required this.isCompatible});
}
