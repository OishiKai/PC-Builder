import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/category_search_parameter.dart';


class CategorySearchParameterNotifier extends StateNotifier<CategorySearchParameter> {
  CategorySearchParameterNotifier(super.state);

  // 検索条件を追加する
  void toggleParameterSelect(String paramName, int index) {
    state = state.toggleParameterSelect(paramName, index);
  }

  // 検索条件をクリア
  void clearSelectedParameter() {
    state = state.clearSelectedParameter();
  }

  // 別のカテゴリの検索条件に切り替える
  void replaceParameters(CategorySearchParameter parameters) {
    state = parameters;
  }
}

final categorySearchParameterProvider = StateProvider<CategorySearchParameter?>((ref) {
  return null;
});