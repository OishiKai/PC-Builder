import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pc_parts.dart';

class SearchingCategoryNotifier extends StateNotifier<PartsCategory> {
  SearchingCategoryNotifier(super.state);

  void changeCategory(PartsCategory category) {
    state = category;
  }
}

final searchingCategoryProvider = StateNotifierProvider<SearchingCategoryNotifier, PartsCategory>(
  (ref) => SearchingCategoryNotifier(PartsCategory.cpu),
);