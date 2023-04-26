import 'package:custom_pc/models/pc_parts.dart';

class CategoryHomeData {
  CategoryHomeData();

  CpuHome? cpu;
  GraphicsCardHome? graphicsCard;

  bool isCpuFilled() {
    if (cpu == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isGraphicsCardFilled() {
    if (graphicsCard == null) {
      return false;
    } else {
      return true;
    }
  }
}

class CpuHome {
  final List<String> intelChips;
  final List<String> amdChips;
  final List<PcParts> popularParts;

  CpuHome(this.intelChips, this.amdChips, this.popularParts);
}

class GraphicsCardHome {
  final List<String> nvidiaChips;
  final List<String> amdChips;
  final List<PcParts> popularParts;

  GraphicsCardHome(this.nvidiaChips, this.amdChips, this.popularParts);
}
