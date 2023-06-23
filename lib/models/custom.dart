import 'dart:math' as math;

import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/compatibility_analyzer.dart';

part 'custom.freezed.dart';

@freezed
class Custom with _$Custom {
  const factory Custom({
    // Custom名
    String? name,
    // 総額
    String? totalPrice,
    // 各パーツ
    PcParts? cpu,
    PcParts? cpuCooler,
    PcParts? memory,
    PcParts? motherBoard,
    PcParts? graphicsCard,
    PcParts? ssd,
    PcParts? pcCase,
    PcParts? powerUnit,
    PcParts? caseFan,

    // 互換性のリスト
    List<PartsCompatibility>? compatibilities,
  }) = _Custom;

  Custom updateCompatibilities() {
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

  bool isEmpty() {
    return cpu == null && cpuCooler == null && memory == null && motherBoard == null && graphicsCard == null && ssd == null && pcCase == null && powerUnit == null && caseFan == null;
  }

  PcParts? get(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return cpu;
      case PartsCategory.cpuCooler:
        return cpuCooler;
      case PartsCategory.memory:
        return memory;
      case PartsCategory.motherBoard:
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

  Map<PartsCategory, PcParts> align() {
    Map<PartsCategory, PcParts> alignedParts = {};

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
      alignedParts[PartsCategory.motherBoard] = motherBoard!;
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

  String getRandomPartsImage() {
    final alignedParts = align();
    final randomNum = math.Random().nextInt(alignedParts.length);
    final randomParts = alignedParts.values.toList()[randomNum];
    return randomParts.image;
  }
}
