import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts.dart';

class CompatibilityAnalyzer {
  static String? _extractSpec(Map<String, String?> specs, String key) {
    String? specInfo;
    specs.forEach((k, v) {
      if (k.contains(key)) {
        specInfo = v;
      }
    });
    return specInfo;
  }

  static PartsCompatibility analyzeCpuMotherAndBoard({required PcParts cpu, required PcParts motherBoard}) {
    // ソケット形状の比較
    String? cpuSocket = _extractSpec(cpu.specs!, 'ソケット形状');
    String? motherBoardSocket = _extractSpec(motherBoard.specs!, 'CPUソケット');

    bool? isCompatibleSockets;
    if (cpuSocket != null && motherBoardSocket != null) {
      cpuSocket = cpuSocket.replaceAll(' ', '');
      motherBoardSocket = motherBoardSocket.replaceAll(' ', '');
      isCompatibleSockets = cpuSocket == motherBoardSocket;
    }

    // チップセットの比較 未実装
    bool? isCompatibleChipsets;

    return PartsCompatibility(
      [PartsCategory.cpu, PartsCategory.motherBoard],
      [cpu.image, motherBoard.image],
      isCompatible: {
        'ソケット形状': isCompatibleSockets,
        'チップセット': isCompatibleChipsets,
      },
    );
  }

  static PartsCompatibility analyzeCpuCoolerAndMotherBoard({required PcParts cpuCooler, required PcParts motherBoard}) {
    // ソケット形状の比較
    String? cpuCoolerIntelSocket = _extractSpec(cpuCooler.specs!, 'Intel対応ソケット');
    String? cpuCoolerAmdSocket = _extractSpec(cpuCooler.specs!, 'AMD対応ソケット');
    String? motherBoardSocket = _extractSpec(motherBoard.specs!, 'CPUソケット');

    final nullCase = PartsCompatibility(
      [PartsCategory.cpuCooler, PartsCategory.motherBoard],
      [cpuCooler.image, motherBoard.image],
      isCompatible: {
        'ソケット形状': null,
      },
    );

    bool isCompatible = false;

    if (motherBoardSocket == null) {
      // マザボのソケット形状が不明な場合は判定不可
      return nullCase;
    }

    // マザボがインテル対応の場合
    if (motherBoardSocket.contains('LGA')) {
      if (cpuCoolerIntelSocket == null) { return nullCase; }
      final motherSocketScrape = motherBoardSocket.replaceAll('LGA', '');

      if (cpuCoolerIntelSocket.contains(motherSocketScrape)) {
        isCompatible = true;
      }
    }

    // マザボがAMD対応の場合
    if (motherBoardSocket.contains('Socket')) {
      if (cpuCoolerAmdSocket == null) { return nullCase; }

      final motherSocketScrape = motherBoardSocket.replaceAll('Socket', '');
      if (cpuCoolerAmdSocket.contains(motherSocketScrape)) {
        isCompatible = true;
      }
    }


    return PartsCompatibility(
      [PartsCategory.cpuCooler, PartsCategory.motherBoard],
      [cpuCooler.image, motherBoard.image],
      isCompatible: {
        'ソケット形状': isCompatible,
      },
    );    
  }
}
