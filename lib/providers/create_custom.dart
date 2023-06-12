import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/compatibility_analyzer.dart';
import '../models/custom.dart';
import '../models/parts_compatibility.dart';
import '../models/pc_parts.dart';

class CreateCustomNotifiler extends StateNotifier<Custom> {
  CreateCustomNotifiler(super.state);
  
  void setParts(PartsCategory category, PcParts parts) {
    switch (category) {
      case PartsCategory.cpu:
        state = state.copyWith(cpu: parts);
        break;
      case PartsCategory.cpuCooler:
        state = state.copyWith(cpuCooler: parts);
        break;
      case PartsCategory.memory:
        state = state.copyWith(memory: parts);
        break;
      case PartsCategory.motherBoard:
        state = state.copyWith(motherBoard: parts);
        break;
      case PartsCategory.graphicsCard:
        state = state.copyWith(graphicsCard: parts);
        break;
      case PartsCategory.ssd:
        state = state.copyWith(ssd: parts);
        break;
      case PartsCategory.powerUnit:
        state = state.copyWith(powerUnit: parts);
        break;
      case PartsCategory.pcCase:
        state = state.copyWith(pcCase: parts);
        break;
      case PartsCategory.caseFan:
        state = state.copyWith(caseFan: parts);
        break;
    }
  }

  void updateState(Custom custom) {
    state = custom;
  }

  void reset() {
    state = const Custom();
  }

  void updateCompatibilities() {
    List<PartsCompatibility> comps = [];
    // 互換性チェック
    if (state.cpu != null && state.motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuAndMotherBoard(cpu: state.cpu!, motherBoard: state.motherBoard!);
      comps.add(compatibility);
    }

    if (state.cpuCooler != null && state.motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuCoolerAndMotherBoard(cpuCooler: state.cpuCooler!, motherBoard: state.motherBoard!);
      comps.add(compatibility);
    }

    if (state.memory != null && state.motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMemoryAndMotherBoard(memory: state.memory!, motherBoard: state.motherBoard!);
      comps.add(compatibility);
    }

    if (state.motherBoard != null && state.ssd != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMotherBoardAndSsd(motherBoard: state.motherBoard!, ssd: state.ssd!);
      comps.add(compatibility);
    }
    final cus = state.copyWith(compatibilities: comps);
    state = cus;
  }
}

final createCustomNotifierProvider = StateNotifierProvider<CreateCustomNotifiler, Custom>((ref) {
  return CreateCustomNotifiler(const Custom());
});