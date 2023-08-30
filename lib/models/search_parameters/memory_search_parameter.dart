import 'package:custom_pc/domain/search_parameter_parser/memory_search_parameter_parser.dart';
import 'package:custom_pc/models/category_search_parameter.dart';

class MemorySearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> volume;
  final List<PartsSearchParameter> interface;
  final List<PartsSearchParameter> type;

  MemorySearchParameter(this.volume, this.interface, this.type);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'容量(一枚あたり)': volume},
      {'インターフェース': interface},
      {'規格': type},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearVolume = [];
    for (var element in volume) {
      element.isSelect = false;
      clearVolume.add(element);
    }
    final List<PartsSearchParameter> clearInterface = [];
    for (var element in interface) {
      element.isSelect = false;
      clearInterface.add(element);
    }
    final List<PartsSearchParameter> clearType = [];
    for (var element in type) {
      element.isSelect = false;
      clearType.add(element);
    }

    return MemorySearchParameter(clearVolume, clearInterface, clearType);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in volume) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in interface) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in type) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in volume) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in interface) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in type) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return MemorySearchParameterParser.standardPage;
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case '容量(一枚あたり)':
        var toggleVolume = volume;
        toggleVolume[index].isSelect = !volume[index].isSelect;
        return MemorySearchParameter(toggleVolume, interface, type);
      case 'インターフェース':
        var toggleInterface = interface;
        toggleInterface[index].isSelect = !interface[index].isSelect;
        return MemorySearchParameter(volume, toggleInterface, type);
      case '規格':
        var toggleType = type;
        toggleType[index].isSelect = !type[index].isSelect;
        return MemorySearchParameter(volume, interface, toggleType);
      default:
        return this;
    }
  }
}
