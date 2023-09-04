import 'package:custom_pc/domain/search_parameter_parser/graphics_card_search_parameter_parser.dart';
import 'package:custom_pc/models/category_search_parameter.dart';

class GraphicsCardSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> nvidiaChips;
  final List<PartsSearchParameter> amdChips;

  GraphicsCardSearchParameter(this.nvidiaChips, this.amdChips);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'チップ(NVIDIA)': nvidiaChips},
      {'チップ(AMD)': amdChips},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearNvidiaChips = [];
    for (var element in nvidiaChips) {
      element.isSelect = false;
      clearNvidiaChips.add(element);
    }
    final List<PartsSearchParameter> clearAmdChips = [];
    for (var element in amdChips) {
      element.isSelect = false;
      clearAmdChips.add(element);
    }

    return GraphicsCardSearchParameter(clearNvidiaChips, clearAmdChips);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in nvidiaChips) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in amdChips) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in nvidiaChips) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in amdChips) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return GraphicsCardSearchParameterParser.standardPage;
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    if (paramName == 'チップ(NVIDIA)') {
      var toggleNviviaChips = nvidiaChips;
      toggleNviviaChips[index].isSelect = !nvidiaChips[index].isSelect;
      return GraphicsCardSearchParameter(toggleNviviaChips, amdChips);
    } else if (paramName == 'チップ(AMD)') {
      var toggleAmdChips = amdChips;
      toggleAmdChips[index].isSelect = !amdChips[index].isSelect;
      return GraphicsCardSearchParameter(nvidiaChips, toggleAmdChips);
    } else {
      return this;
    }
  }
}
