import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/compatibility_analyzer.dart';
import '../../models/custom.dart';
import '../../models/parts_compatibility.dart';
import '../../models/pc_parts.dart';
import '../pages/dashboard.dart';

part 'gen/edit_custom.g.dart';

@Riverpod(keepAlive: true)
class EditCustomNotifier extends _$EditCustomNotifier {
  @override
  Custom build() {
    return const Custom();
  }

  /// 保存済みのカスタムを編集する場合
  void setCustom(Custom custom) {
    state = custom;
    updateCompatibilities();
    ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => false);
  }

  /// カスタム名を変更する
  void rename(String name) {
    state = state.copyWith(name: name);
  }

  /// パーツを追加・変更
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
      case PartsCategory.motherboard:
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
    updateCompatibilities();
  }

  /// パーツを削除
  void removeParts(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        state = state.copyWith(cpu: null);
        break;
      case PartsCategory.cpuCooler:
        state = state.copyWith(cpuCooler: null);
        break;
      case PartsCategory.memory:
        state = state.copyWith(memory: null);
        break;
      case PartsCategory.motherboard:
        state = state.copyWith(motherBoard: null);
        break;
      case PartsCategory.graphicsCard:
        state = state.copyWith(graphicsCard: null);
        break;
      case PartsCategory.ssd:
        state = state.copyWith(ssd: null);
        break;
      case PartsCategory.powerUnit:
        state = state.copyWith(powerUnit: null);
        break;
      case PartsCategory.pcCase:
        state = state.copyWith(pcCase: null);
        break;
      case PartsCategory.caseFan:
        state = state.copyWith(caseFan: null);
        break;
    }
  }

  /// 互換性情報を更新
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
