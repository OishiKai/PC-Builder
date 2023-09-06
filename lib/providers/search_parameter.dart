import 'package:custom_pc/models/category_search_parameter.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/providers/searching_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_parameter.g.dart';

@Riverpod(keepAlive: true)
class SearchParameterNotifier extends _$SearchParameterNotifier {
  @override
  Map<PartsCategory, CategorySearchParameter>? build() {
    return null;
  }

  void set(Map<PartsCategory, CategorySearchParameter> params) {
    state = params;
  }

  void resetParams() {
    final category = ref.watch(searchingCategoryProvider);
    final reset = state![category]!.clearSelectedParameter();
    state![category] = reset;
  }
}
