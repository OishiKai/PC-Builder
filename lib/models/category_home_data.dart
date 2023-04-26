import 'package:custom_pc/models/pc_parts.dart';

class CategoryHomeData {
  CategoryHomeData();

  CpuHome? cpu;
  CpuCoolerHome? cpuCooler;
  GraphicsCardHome? graphicsCard;

  bool isCpuFilled() {
    if (cpu == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isCpuCooler() {
    if (cpuCooler == null) {
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

class CpuCoolerHome {
  final List<String> makers;
  final List<PcParts> popularParts;

  CpuCoolerHome(this.makers, this.popularParts);
}

class GraphicsCardHome {
  final List<String> nvidiaChips;
  final List<String> amdChips;
  final List<PcParts> popularParts;

  GraphicsCardHome(this.nvidiaChips, this.amdChips, this.popularParts);
}
