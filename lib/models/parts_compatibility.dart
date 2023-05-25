import 'package:custom_pc/models/pc_parts.dart';

class PartsCompatibility {
  final List<PartsCategory> pair;
  Map<String, bool?> isCompatible;

  PartsCompatibility(this.pair, {required this.isCompatible});
}