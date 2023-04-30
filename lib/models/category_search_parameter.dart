abstract class CategorySearchParameter {
  List<String> selectedParameters();
  CategorySearchParameter clearSelectedParameter();
}

class PartsSearchParameter {
  final String key;
  final String value;
  bool isSelect = false;
  PartsSearchParameter(this.key, this.value);
}
