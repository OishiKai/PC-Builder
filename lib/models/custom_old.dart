import 'package:custom_pc/models/parts_category.dart';
import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts_old.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/compatibility_analyzer.dart';

part 'custom_old.freezed.dart';

@freezed
class CustomOld with _$CustomOld {
  const factory CustomOld({
    String? id,
    // Custom名
    String? name,
    // 総額
    String? totalPrice,
    // 各パーツ
    PcPartsOld? cpu,
    PcPartsOld? cpuCooler,
    PcPartsOld? memory,
    PcPartsOld? motherBoard,
    PcPartsOld? graphicsCard,
    PcPartsOld? ssd,
    PcPartsOld? pcCase,
    PcPartsOld? powerUnit,
    PcPartsOld? caseFan,

    // 保存日
    String? date,

    // 互換性のリスト
    List<PartsCompatibility>? compatibilities,
  }) = _Custom;

  CustomOld updateCompatibilities() {
    List<PartsCompatibility> comps = [];
    // 互換性チェック
    if (cpu != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuAndMotherBoard(cpu: cpu!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (cpuCooler != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuCoolerAndMotherBoard(cpuCooler: cpuCooler!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (memory != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMemoryAndMotherBoard(memory: memory!, motherBoard: motherBoard!);
      comps.add(compatibility);
    }

    if (motherBoard != null && ssd != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMotherBoardAndSsd(motherBoard: motherBoard!, ssd: ssd!);
      comps.add(compatibility);
    }
    return copyWith(compatibilities: comps);
  }

  int parsePrice(String price) {
    final normalizedPrice = price.trim().replaceAll('¥', '').replaceAll(',', '');
    return normalizedPrice.isEmpty ? 0 : int.parse(normalizedPrice);
  }

  int calculateTotalPrice() {
    int totalPrice = 0;

    if (cpu != null) {
      totalPrice += parsePrice(cpu!.price);
    }
    if (cpuCooler != null) {
      totalPrice += parsePrice(cpuCooler!.price);
    }
    if (memory != null) {
      totalPrice += parsePrice(memory!.price);
    }
    if (motherBoard != null) {
      totalPrice += parsePrice(motherBoard!.price);
    }
    if (graphicsCard != null) {
      totalPrice += parsePrice(graphicsCard!.price);
    }
    if (ssd != null) {
      totalPrice += parsePrice(ssd!.price);
    }
    if (pcCase != null) {
      totalPrice += parsePrice(pcCase!.price);
    }
    if (powerUnit != null) {
      totalPrice += parsePrice(powerUnit!.price);
    }
    if (caseFan != null) {
      totalPrice += parsePrice(caseFan!.price);
    }

    return totalPrice;
  }

  String formatPrice() {
    final String stringValue = calculateTotalPrice().toString();
    final StringBuffer buffer = StringBuffer();

    buffer.write('¥');

    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }

    return buffer.toString();
  }

  bool isEmpty() {
    return cpu == null && cpuCooler == null && memory == null && motherBoard == null && graphicsCard == null && ssd == null && pcCase == null && powerUnit == null && caseFan == null;
  }

  PcPartsOld? get(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return cpu;
      case PartsCategory.cpuCooler:
        return cpuCooler;
      case PartsCategory.memory:
        return memory;
      case PartsCategory.motherboard:
        return motherBoard;
      case PartsCategory.graphicsCard:
        return graphicsCard;
      case PartsCategory.ssd:
        return ssd;
      case PartsCategory.pcCase:
        return pcCase;
      case PartsCategory.powerUnit:
        return powerUnit;
      case PartsCategory.caseFan:
        return caseFan;
    }
  }

  Map<PartsCategory, PcPartsOld> align() {
    Map<PartsCategory, PcPartsOld> alignedParts = {};

    if (cpu != null) {
      alignedParts[PartsCategory.cpu] = cpu!;
    }

    if (cpuCooler != null) {
      alignedParts[PartsCategory.cpuCooler] = cpuCooler!;
    }

    if (memory != null) {
      alignedParts[PartsCategory.memory] = memory!;
    }

    if (motherBoard != null) {
      alignedParts[PartsCategory.motherboard] = motherBoard!;
    }

    if (graphicsCard != null) {
      alignedParts[PartsCategory.graphicsCard] = graphicsCard!;
    }

    if (ssd != null) {
      alignedParts[PartsCategory.ssd] = ssd!;
    }

    if (pcCase != null) {
      alignedParts[PartsCategory.pcCase] = pcCase!;
    }

    if (powerUnit != null) {
      alignedParts[PartsCategory.powerUnit] = powerUnit!;
    }

    if (caseFan != null) {
      alignedParts[PartsCategory.caseFan] = caseFan!;
    }

    return alignedParts;
  }

  String getMainPartsImage() {
    final alignedParts = align();
    // 最も高い価格のパーツを取得
    final parts = alignedParts.values.reduce((a, b) => parsePrice(a.price) > parsePrice(b.price) ? a : b);
    return parts.image;
  }
}
