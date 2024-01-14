import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/search_parameter_fetcher.dart';
import '../models/category_search_parameter.dart';
import '../models/parts_category.dart';
import 'searching_category.dart';

part 'gen/search_parameter.g.dart';

@Riverpod(keepAlive: true)
class SearchParameterNotifier extends _$SearchParameterNotifier {
  @override
  Map<PartsCategory, CategorySearchParameter>? build() {
    return null;
  }

  void set(Map<PartsCategory, CategorySearchParameter> params) {
    state = params;
  }

  void toggleParameterSelect(String paramName, int index) {
    final category = ref.read(searchingCategoryProvider);
    final toggled = state![category]!.toggleParameterSelect(paramName, index);
    final params = SearchParameterFetcher.copyWith(state!, category, toggled);
    state = params;
  }

  void clearSelectedParameter() {
    final category = ref.read(searchingCategoryProvider);
    final newState = SearchParameterFetcher.copyWith(state!, category, null);
    state = newState;
  }
}
