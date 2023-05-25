import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts.dart';

class CompatibilityAnalyzer {
  static String? _extractSpec(Map<String, String?> specs, String key) {
    String? specInfo;
    specs.forEach((k, v) {
      print('$k: $v');
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
    print(cpuSocket);
    print(motherBoardSocket);

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
}
