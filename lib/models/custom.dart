import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Custom {
  final PcParts? cpu;
  final PcParts? cpuCooler;
  final PcParts? memory;
  final PcParts? motherBoard;
  final PcParts? graphicsCard;
  final PcParts? ssd;
  final PcParts? pcCase;
  final PcParts? powerUnit;
  final PcParts? caseFan;

  Custom._(this.cpu, this.cpuCooler, this.memory, this.motherBoard, this.graphicsCard, this.ssd, this.pcCase, this.powerUnit, this.caseFan);

  static Custom create() {
    return Custom._(null, null, null, null, null, null, null, null, null);
  }

  Custom copyWith({PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan}) {
    return Custom._(cpu ?? this.cpu, cpuCooler ?? this.cpuCooler, memory ?? this.memory, motherBoard ?? this.motherBoard, graphicsCard ?? this.graphicsCard, ssd ?? this.ssd, pcCase ?? this.pcCase, powerUnit ?? this.powerUnit, caseFan ?? this.caseFan);
  }
}

class CustomNotifier extends StateNotifier<Custom> {
  CustomNotifier(super.state);

  void setCpu(PcParts cpu) {
    state = state.copyWith(cpu: cpu);
  }

  void setCpuCooler(PcParts cpuCooler) {
    state = state.copyWith(cpuCooler: cpuCooler);
  }

  void setMemory(PcParts memory) {
    state = state.copyWith(memory: memory);
  }

  void setMotherBoard(PcParts motherBoard) {
    state = state.copyWith(motherBoard: motherBoard);
  }

  void setGraphicsCard(PcParts graphicsCard) {
    state = state.copyWith(graphicsCard: graphicsCard);
  }

  void setSsd(PcParts ssd) {
    state = state.copyWith(ssd: ssd);
  }

  void setPcCase(PcParts pcCase) {
    state = state.copyWith(pcCase: pcCase);
  }

  void setPowerUnit(PcParts powerUnit) {
    state = state.copyWith(powerUnit: powerUnit);
  }

  void setCaseFan(PcParts caseFan) {
    state = state.copyWith(caseFan: caseFan);
  }

  void reset() {
    state = Custom.create();
  }

  void setCustom(Custom custom) {
    state = custom;
  }
}




