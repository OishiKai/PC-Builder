abstract class CategorySearchParameter {
  String standardPage();
  List<String> selectedParameters();
  CategorySearchParameter clearSelectedParameter();
  List<Map<String, List<PartsSearchParameter>>> alignParameters();
  CategorySearchParameter toggleParameterSelect(String paramName, int index);
}

class PartsSearchParameter {
  final String key;
  final String value;
  bool isSelect = false;
  PartsSearchParameter(this.key, this.value);
}
