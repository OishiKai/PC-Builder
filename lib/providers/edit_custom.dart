import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/compatibility_analyzer.dart';
import '../models/custom.dart';
import '../models/parts_category.dart';
import '../models/parts_compatibility.dart';
import '../models/pc_parts.dart';

part 'gen/edit_custom.g.dart';

@Riverpod(keepAlive: true)
class EditCustomNotifier extends _$EditCustomNotifier {
  @override
  Custom build() {
    return const Custom();
  }

  /// カスタムを新規作成する場合
  void createCustom() {
    state = const Custom();
  }

  /// 保存済みのカスタムを編集する場合
  void setCustom(Custom custom) {
    state = custom;
    updateCompatibilities();
  }

  /// カスタム名を変更する
  void rename(String name) {
    state = state.copyWith(name: name);
  }

  /// パーツを追加・変更
  void setParts(PartsCategory category, PcParts parts) {
    final partsList = state.parts;
    if (partsList == null) {
      state = state.copyWith(parts: [parts]);
      return;
    } else {
      final index = partsList.indexWhere((element) => element.category == category);
      if (index == -1) {
        state = state.copyWith(parts: [...partsList, parts]);
      } else {
        partsList[index] = parts;
        state = state.copyWith(parts: partsList);
      }
    }

    // switch (category) {
    //   case PartsCategory.cpu:
    //     state = state.copyWith(cpu: parts);
    //     break;
    //   case PartsCategory.cpuCooler:
    //     state = state.copyWith(cpuCooler: parts);
    //     break;
    //   case PartsCategory.memory:
    //     state = state.copyWith(memory: parts);
    //     break;
    //   case PartsCategory.motherboard:
    //     state = state.copyWith(motherBoard: parts);
    //     break;
    //   case PartsCategory.graphicsCard:
    //     state = state.copyWith(graphicsCard: parts);
    //     break;
    //   case PartsCategory.ssd:
    //     state = state.copyWith(ssd: parts);
    //     break;
    //   case PartsCategory.powerUnit:
    //     state = state.copyWith(powerUnit: parts);
    //     break;
    //   case PartsCategory.pcCase:
    //     state = state.copyWith(pcCase: parts);
    //     break;
    //   case PartsCategory.caseFan:
    //     state = state.copyWith(caseFan: parts);
    //     break;
    // }
    updateCompatibilities();
  }

  /// パーツを削除
  void removeParts(PartsCategory category) {
    final partsList = state.parts;
    if (partsList == null) {
      return;
    } else {
      final index = partsList.indexWhere((element) => element.category == category);
      if (index == -1) {
        return;
      } else {
        partsList.removeAt(index);
        state = state.copyWith(parts: partsList);
      }
    }
    // switch (category) {
    //   case PartsCategory.cpu:
    //     state = state.copyWith(cpu: null);
    //     break;
    //   case PartsCategory.cpuCooler:
    //     state = state.copyWith(cpuCooler: null);
    //     break;
    //   case PartsCategory.memory:
    //     state = state.copyWith(memory: null);
    //     break;
    //   case PartsCategory.motherboard:
    //     state = state.copyWith(motherBoard: null);
    //     break;
    //   case PartsCategory.graphicsCard:
    //     state = state.copyWith(graphicsCard: null);
    //     break;
    //   case PartsCategory.ssd:
    //     state = state.copyWith(ssd: null);
    //     break;
    //   case PartsCategory.powerUnit:
    //     state = state.copyWith(powerUnit: null);
    //     break;
    //   case PartsCategory.pcCase:
    //     state = state.copyWith(pcCase: null);
    //     break;
    //   case PartsCategory.caseFan:
    //     state = state.copyWith(caseFan: null);
    //     break;
    // }
  }

  /// 互換性情報を更新
  void updateCompatibilities() {
    List<PartsCompatibility> comps = [];

    if (state.parts == null) {
      return;
    }

    final cpu = state.parts!.firstWhereOrNull((element) => element.category == PartsCategory.cpu);
    final cpuCooler = state.parts!.firstWhereOrNull((element) => element.category == PartsCategory.cpuCooler);
    final memory = state.parts!.firstWhereOrNull((element) => element.category == PartsCategory.memory);
    final motherBoard = state.parts!.firstWhereOrNull((element) => element.category == PartsCategory.motherboard);
    final ssd = state.parts!.firstWhereOrNull((element) => element.category == PartsCategory.ssd);

    // 互換性チェック
    if (cpu != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuAndMotherBoard(cpu: cpu, motherBoard: motherBoard);
      comps.add(compatibility);
    }

    if (cpuCooler != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeCpuCoolerAndMotherBoard(cpuCooler: cpuCooler, motherBoard: motherBoard);
      comps.add(compatibility);
    }

    if (memory != null && motherBoard != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMemoryAndMotherBoard(memory: memory, motherBoard: motherBoard);
      comps.add(compatibility);
    }

    if (motherBoard != null && ssd != null) {
      final compatibility = CompatibilityAnalyzer.analyzeMotherBoardAndSsd(motherBoard: motherBoard, ssd: ssd);
      comps.add(compatibility);
    }
    final cus = state.copyWith(compatibilities: comps);
    state = cus;
  }
}
