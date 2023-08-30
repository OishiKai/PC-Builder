import 'package:custom_pc/domain/search_parameter_parser/ssd_search_parameter_parser.dart';
import 'package:custom_pc/models/category_search_parameter.dart';

class SsdSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> volumes;
  final List<PartsSearchParameter> type;
  final List<PartsSearchParameter> interface;

  SsdSearchParameter(this.volumes, this.type, this.interface);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'容量': volumes},
      {'規格': type},
      {'インターフェース': interface},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearVolumes = [];
    for (var element in volumes) {
      element.isSelect = false;
      clearVolumes.add(element);
    }
    final List<PartsSearchParameter> clearType = [];
    for (var element in type) {
      element.isSelect = false;
      clearType.add(element);
    }
    final List<PartsSearchParameter> clearInterface = [];
    for (var element in interface) {
      element.isSelect = false;
      clearInterface.add(element);
    }

    return SsdSearchParameter(clearVolumes, clearType, clearInterface);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in volumes) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in type) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in interface) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in volumes) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in type) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in interface) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return SsdSearchParameterParser.standardPage;
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    if (paramName == '容量') {
      var toggleVolumes = volumes;
      toggleVolumes[index].isSelect = !volumes[index].isSelect;
      return SsdSearchParameter(toggleVolumes, type, interface);
    } else if (paramName == '規格') {
      var toggleType = type;
      toggleType[index].isSelect = !type[index].isSelect;
      return SsdSearchParameter(volumes, toggleType, interface);
    } else if (paramName == 'インターフェース') {
      var toggleInterface = interface;
      toggleInterface[index].isSelect = !interface[index].isSelect;
      return SsdSearchParameter(volumes, type, toggleInterface);
    } else {
      return this;
    }
  }
}
