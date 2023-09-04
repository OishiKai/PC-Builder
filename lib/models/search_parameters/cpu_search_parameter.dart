import '../../domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';
import '../category_search_parameter.dart';

class CpuSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> makers;
  final List<PartsSearchParameter> processors;
  final List<PartsSearchParameter> series;
  final List<PartsSearchParameter> sockets;
  CpuSearchParameter(this.makers, this.processors, this.series, this.sockets);

  @override
  CpuSearchParameter clearSelectedParameter() {
    final List<PartsSearchParameter> clearMaker = [];
    for (var element in makers) {
      element.isSelect = false;
      clearMaker.add(element);
    }
    final List<PartsSearchParameter> clearProcessor = [];
    for (var element in processors) {
      element.isSelect = false;
      clearProcessor.add(element);
    }
    final List<PartsSearchParameter> clearSeries = [];
    for (var element in series) {
      element.isSelect = false;
      clearSeries.add(element);
    }
    final List<PartsSearchParameter> clearSockets = [];
    for (var element in sockets) {
      element.isSelect = false;
      clearSockets.add(element);
    }

    return CpuSearchParameter(clearMaker, clearProcessor, clearSeries, clearSockets);
  }

  @override
  List<String> selectedParameters() {
    List<String> params = [];
    for (var element in makers) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in processors) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in series) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    for (var element in sockets) {
      if (element.isSelect) {
        params.add(element.parameter);
      }
    }
    return params;
  }

  @override
  List<String> selectedParameterNames() {
    List<String> params = [];
    for (var element in makers) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in processors) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in series) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    for (var element in sockets) {
      if (element.isSelect) {
        params.add(element.name);
      }
    }
    return params;
  }

  @override
  List<Map<String, List<PartsSearchParameter>>> alignParameters() {
    return [
      {'メーカー': makers},
      {'プロセッサ': processors},
      {'世代': series},
      {'ソケット形状': sockets},
    ];
  }

  @override
  CpuSearchParameter toggleParameterSelect(String paramName, int index) {
    switch (paramName) {
      case 'メーカー':
        var toggleMaker = makers;
        toggleMaker[index].isSelect = !makers[index].isSelect;
        return CpuSearchParameter(toggleMaker, processors, series, sockets);
      case 'プロセッサ':
        var toggleProcessors = processors;
        toggleProcessors[index].isSelect = !processors[index].isSelect;
        return CpuSearchParameter(makers, toggleProcessors, series, sockets);
      case '世代':
        var toggleSeries = series;
        toggleSeries[index].isSelect = !series[index].isSelect;
        return CpuSearchParameter(makers, processors, toggleSeries, sockets);
      case 'ソケット形状':
        var toggleSockets = sockets;
        toggleSockets[index].isSelect = !sockets[index].isSelect;
        return CpuSearchParameter(makers, processors, series, toggleSockets);
      default:
        return CpuSearchParameter(makers, processors, series, sockets);
    }
  }

  @override
  String standardPage() {
    return CpuSearchParameterParser.standardPage;
  }
}
