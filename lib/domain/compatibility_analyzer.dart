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

  static PartsCompatibility analyzeCpuAndMotherBoard({required PcParts cpu, required PcParts motherBoard}) {
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
      [PartsCategory.cpu, PartsCategory.motherboard],
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
      [PartsCategory.cpuCooler, PartsCategory.motherboard],
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
      if (cpuCoolerIntelSocket == null) {
        return nullCase;
      }
      final motherSocketScrape = motherBoardSocket.replaceAll('LGA', '');

      if (cpuCoolerIntelSocket.contains(motherSocketScrape)) {
        isCompatible = true;
      }
    }

    // マザボがAMD対応の場合
    if (motherBoardSocket.contains('Socket')) {
      if (cpuCoolerAmdSocket == null) {
        return nullCase;
      }

      final motherSocketScrape = motherBoardSocket.replaceAll('Socket', '');
      if (cpuCoolerAmdSocket.contains(motherSocketScrape)) {
        isCompatible = true;
      }
    }

    return PartsCompatibility(
      [PartsCategory.cpuCooler, PartsCategory.motherboard],
      [cpuCooler.image, motherBoard.image],
      isCompatible: {
        'ソケット形状': isCompatible,
      },
    );
  }

  static PartsCompatibility analyzeMemoryAndMotherBoard({required PcParts memory, required PcParts motherBoard}) {
    // メモリの規格の比較
    String? memoryStandard = _extractSpec(memory.specs!, 'メモリ規格');
    String? motherBoardStandard = _extractSpec(motherBoard.specs!, '詳細メモリタイプ');

    bool? isCompatibleStandards;

    if (memoryStandard != null && motherBoardStandard != null) {
      // "DDR4 SDRAM" -> "DDR4" に変換
      memoryStandard = memoryStandard.split(' ')[0];
      if (motherBoardStandard.contains(memoryStandard)) {
        isCompatibleStandards = true;
      } else {
        isCompatibleStandards = false;
      }
    }

    // メモリの枚数の比較
    String? numberOfMemory = _extractSpec(memory.specs!, '枚数');
    String? numberOfMemorySlots = _extractSpec(motherBoard.specs!, 'メモリスロット数');

    bool? isCompatibleSlots;

    if (numberOfMemory != null && numberOfMemorySlots != null) {
      // メモリ枚数、メモリスロット数を数値に変換
      final numberOfMemoryInt = int.tryParse(numberOfMemory.replaceAll('枚', ''));
      final numberOfMemorySlotsInt = int.tryParse(numberOfMemorySlots);

      if (numberOfMemoryInt != null && numberOfMemorySlotsInt != null) {
        // メモリ枚数がメモリスロット数以下であれば互換性あり
        if (numberOfMemoryInt <= numberOfMemorySlotsInt) {
          isCompatibleSlots = true;
        } else {
          isCompatibleSlots = false;
        }
      }
    }

    return PartsCompatibility(
      [PartsCategory.memory, PartsCategory.motherboard],
      [memory.image, motherBoard.image],
      isCompatible: {
        '規格': isCompatibleStandards,
        'メモリスロット数': isCompatibleSlots,
      },
    );
  }

  static PartsCompatibility analyzeMotherBoardAndSsd({required PcParts motherBoard, required PcParts ssd}) {
    String? ssdStandardSize = _extractSpec(ssd.specs!, '規格サイズ');

    // サイズ不明
    if (ssdStandardSize == null) {
      return PartsCompatibility(
        [PartsCategory.motherboard, PartsCategory.ssd],
        [motherBoard.image, ssd.image],
        isCompatible: {
          '互換性': null,
        },
      );
    }

    // M.2の場合
    if (ssdStandardSize.contains('M.2')) {
      String? motherBoardM2Sockets = _extractSpec(motherBoard.specs!, 'M.2ソケット数');
      String? motherBoardM2Size = _extractSpec(motherBoard.specs!, 'M.2サイズ');

      // M.2ソケット数の情報があるなら対応していると判定
      bool? isCompatibleSockets = motherBoardM2Sockets != null;
      bool? isCompatibleSize;

      // "M.2 (Type0000)" -> "0000" に変換
      ssdStandardSize = ssdStandardSize.trim().split('M.2 (Type')[1].replaceAll(')', '');
      if (motherBoardM2Size != null) {
        // M.2サイズ情報があるなら一致しているか判定
        isCompatibleSize = motherBoardM2Size.contains(ssdStandardSize);
      }

      return PartsCompatibility(
        [PartsCategory.motherboard, PartsCategory.ssd],
        [motherBoard.image, ssd.image],
        isCompatible: {
          'ソケット数': isCompatibleSockets,
          'サイズ': isCompatibleSize,
        },
      );
    }

    // 2.5インチの場合
    if (ssdStandardSize.contains('2.5インチ')) {
      String? motherBoardSataPorts = _extractSpec(motherBoard.specs!, 'SATA');

      return PartsCompatibility(
        [PartsCategory.motherboard, PartsCategory.ssd],
        [motherBoard.image, ssd.image],
        isCompatible: {
          // SATAの情報があるなら対応していると判定
          'SATAポート数': motherBoardSataPorts != null,
        },
      );
    }

    // M.2, 2.5インチ以外の場合
    return PartsCompatibility(
      [PartsCategory.motherboard, PartsCategory.ssd],
      [motherBoard.image, ssd.image],
      isCompatible: {
        '互換性': null,
      },
    );
  }
}
