import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/parts_category.dart';

/// パーツの検索開始時、検索するパーツのカテゴリを設定する
final searchingCategoryProvider = StateProvider<PartsCategory>((ref) => PartsCategory.cpu);
