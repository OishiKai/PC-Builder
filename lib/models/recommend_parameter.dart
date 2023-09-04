import 'package:custom_pc/models/pc_parts.dart';

class RecommendParameter {
  final PartsCategory category;
  final int paramSectionIndex;
  final String paramValueName;
  final int paramIndex;

  RecommendParameter(this.category, this.paramSectionIndex, this.paramValueName, this.paramIndex);
}
