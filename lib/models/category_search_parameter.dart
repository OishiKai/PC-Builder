abstract class CategorySearchParameter {
  String standardPage();
  List<String> selectedParameters();
  CategorySearchParameter clearSelectedParameter();
  List<Map<String, List<PartsSearchParameter>>> alignParameters();
  CategorySearchParameter toggleParameterSelect(String paramName, int index);
}

class PartsSearchParameter {
  final String name;
  final String parameter;
  bool isSelect = false;
  PartsSearchParameter(this.name, this.parameter);
}
