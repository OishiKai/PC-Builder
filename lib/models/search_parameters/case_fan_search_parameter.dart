import 'package:custom_pc/models/category_search_parameter.dart';

class CaseFanSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> maker;
  final List<PartsSearchParameter> size;
  final List<PartsSearchParameter> maxAirVolume;

  CaseFanSearchParameter(this.maker, this.size, this.maxAirVolume);

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'メーカー': maker},
      {'サイズ': size},
      {'最大風量': maxAirVolume},
    ];
  }

  @override
  CategorySearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearMaker = [];
    for (var element in maker) {
      element.isSelect = false;
      clearMaker.add(element);
    }
    final List<PartsSearchParameter> clearSize = [];
    for (var element in size) {
      element.isSelect = false;
      clearSize.add(element);
    }
    final List<PartsSearchParameter> clearMaxAirVolume = [];
    for (var element in maxAirVolume) {
      element.isSelect = false;
      clearMaxAirVolume.add(element);
    }

    return CaseFanSearchParameter(clearMaker, clearSize, clearMaxAirVolume);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in maker) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in size) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in maxAirVolume) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in maker) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in size) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in maxAirVolume) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  String standardPage() {
    return 'https://kakaku.com/pc/case-fan/itemlist.aspx';
  }

  @override
  CategorySearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case 'メーカー':
        var toggleMaker = maker;
        toggleMaker[index].isSelect = !maker[index].isSelect;
        return CaseFanSearchParameter(toggleMaker, size, maxAirVolume);
      case 'サイズ':
        var toggleSize = size;
        toggleSize[index].isSelect = !size[index].isSelect;
        return CaseFanSearchParameter(maker, toggleSize, maxAirVolume);
      case '最大風量':
        var toggleMaxAirVolume = maxAirVolume;
        toggleMaxAirVolume[index].isSelect = !maxAirVolume[index].isSelect;
        return CaseFanSearchParameter(maker, size, toggleMaxAirVolume);
      default:
        return this;
    }
  }
}
