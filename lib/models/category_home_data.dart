import 'package:custom_pc/models/pc_parts.dart';

class CategoryHomeData {
  CategoryHomeData();

  CpuHome? cpu;
  CpuCoolerHome? cpuCooler;
  MemoryHome? memory;
  MotherBoardHome? motherBoard;
  GraphicsCardHome? graphicsCard;
  SsdHome? ssd;
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

class MemoryHome {
  final Map<String, List<String>> memoryTypes;
  final List<PcParts> popularParts;

  MemoryHome(this.memoryTypes, this.popularParts);
}

class MotherBoardHome {
  final List<String> intelSocket;
  final List<String> amdSocket;
  final List<PcParts> popularParts;

  MotherBoardHome(this.intelSocket, this.amdSocket, this.popularParts);
}

class GraphicsCardHome {
  final List<String> nvidiaChips;
  final List<String> amdChips;
  final List<PcParts> popularParts;

  GraphicsCardHome(this.nvidiaChips, this.amdChips, this.popularParts);
}

class SsdHome {
  final List<String> capacityList = ['2000GB', '1000GB', '512GB', '256GB'];
  final List<String> typeList = ['M.2', '2.5インチ'];
  final List<PcParts> popularParts;

  SsdHome(this.popularParts);
}
