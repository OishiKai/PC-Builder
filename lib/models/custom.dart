import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/compatibility_analyzer.dart';

part 'custom.freezed.dart';

@freezed
class Custom with _$Custom {
  const factory Custom({
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
}