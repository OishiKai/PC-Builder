import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// パーツの検索開始時、検索するパーツのカテゴリを設定する
final searchingCategoryProvider = StateProvider<PartsCategory>((ref) => PartsCategory.cpu);
