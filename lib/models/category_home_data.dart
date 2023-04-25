import 'package:custom_pc/models/pc_parts.dart';

class CategoryHomeData {
  CategoryHomeData();

  GraphicsCardHome? graphicsCard;

  bool isGraphicsCardFilled() {
    if (graphicsCard == null) {
      return false;
    } else {
      return true;
    }
  }
}

class GraphicsCardHome {
  final List<String> nvidiaChips;
  final List<String> amdChips;
  final List<PcParts> recommendParts;

  GraphicsCardHome(this.nvidiaChips, this.amdChips, this.recommendParts);
}
