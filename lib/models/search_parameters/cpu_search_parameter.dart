import '../category_search_parameter.dart';

class CpuSearchParameter extends CategorySearchParameter {
  final List<PartsSearchParameter> makers;
  final List<PartsSearchParameter> processors;
  final List<PartsSearchParameter> series;
  final List<PartsSearchParameter> sockets;

  CpuSearchParameter(this.makers, this.processors, this.series, this.sockets);

  @override
  CategorySearchParameter clearSelectedParameter() {
    // TODO: implement clearSelectedParameter
    throw UnimplementedError();
  }

  @override
  List<String> selectedParameters() {
    // TODO: implement selectedParameters
    throw UnimplementedError();
  }
}
