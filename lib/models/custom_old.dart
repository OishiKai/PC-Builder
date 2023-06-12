// import 'package:custom_pc/models/parts_compatibility.dart';
// import 'package:custom_pc/models/pc_parts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomOld {
//   final PcParts? cpu;
//   final PcParts? cpuCooler;
//   final PcParts? memory;
//   final PcParts? motherBoard;
//   final PcParts? graphicsCard;
//   final PcParts? ssd;
//   final PcParts? pcCase;
//   final PcParts? powerUnit;
//   final PcParts? caseFan;

//   final List<PartsCompatibility>? compatibilities;

//   CustomOld._(this.cpu, this.cpuCooler, this.memory, this.motherBoard, this.graphicsCard, this.ssd, this.pcCase, this.powerUnit, this.caseFan, this.compatibilities);

//   static CustomOld create() {
//     return CustomOld._(null, null, null, null, null, null, null, null, null, null);
//   }

//   CustomOld copyWith({PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan}) {
//     return CustomOld._(cpu ?? this.cpu, cpuCooler ?? this.cpuCooler, memory ?? this.memory, motherBoard ?? this.motherBoard, graphicsCard ?? this.graphicsCard, ssd ?? this.ssd, pcCase ?? this.pcCase, powerUnit ?? this.powerUnit, caseFan ?? this.caseFan, compatibilities);
//   }

//   CustomOld deleteWith({PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan}) {
//     return CustomOld._(null, null, null, null, null, null, null, null, null, null);
//   }

//   CustomOld addCompatibility(PartsCompatibility compatibility) {
    // // 互換性のリストがnullの場合は新規作成
    // if (compatibilities == null) {
    //   return CustomOld._(cpu, cpuCooler, memory, motherBoard, graphicsCard, ssd, pcCase, powerUnit, caseFan, [compatibility]);
    // }

    // // 互換性のリストがnullでなく、すでに同じパーツの互換性情報がある場合は上書き
    // final storedComps = compatibilities!;
    // for(var i = 0; i < storedComps.length; i++) {
    //   if (storedComps[i].pair[0] == compatibility.pair[0] && storedComps[i].pair[1] == compatibility.pair[1]) {
    //     storedComps[i] = compatibility;
    //     return CustomOld._(cpu, cpuCooler, memory, motherBoard, graphicsCard, ssd, pcCase, powerUnit, caseFan, storedComps);
    //   }
    // }
    // // 互換性のリストがnullでなく、同じパーツの互換性情報がない場合は追加
    // storedComps.add(compatibility);
    // return CustomOld._(cpu, cpuCooler, memory, motherBoard, graphicsCard, ssd, pcCase, powerUnit, caseFan, storedComps);
//   }

//   int calculateTotalPrice() {
//     int totalPrice = 0;

//     if (cpu != null) {
//       totalPrice += parsePrice(cpu!.price);
//     }
//     if (cpuCooler != null) {
//       totalPrice += parsePrice(cpuCooler!.price);
//     }
//     if (memory != null) {
//       totalPrice += parsePrice(memory!.price);
//     }
//     if (motherBoard != null) {
//       totalPrice += parsePrice(motherBoard!.price);
//     }
//     if (graphicsCard != null) {
//       totalPrice += parsePrice(graphicsCard!.price);
//     }
//     if (ssd != null) {
//       totalPrice += parsePrice(ssd!.price);
//     }
//     if (pcCase != null) {
//       totalPrice += parsePrice(pcCase!.price);
//     }
//     if (powerUnit != null) {
//       totalPrice += parsePrice(powerUnit!.price);
//     }
//     if (caseFan != null) {
//       totalPrice += parsePrice(caseFan!.price);
//     }

//     return totalPrice;
//   }

//   int parsePrice(String price) {
//     final normalizedPrice = price.trim().replaceAll('¥', '').replaceAll(',', '');
//     return normalizedPrice.isEmpty ? 0 : int.parse(normalizedPrice);
//   }


//   bool isEmpty() {
//     return cpu == null && cpuCooler == null && memory == null && motherBoard == null && graphicsCard == null && ssd == null && pcCase == null && powerUnit == null && caseFan == null;
//   }

//   PcParts? get(PartsCategory category) {
//     switch (category) {
//       case PartsCategory.cpu:
//         return cpu;
//       case PartsCategory.cpuCooler:
//         return cpuCooler;
//       case PartsCategory.memory:
//         return memory;
//       case PartsCategory.motherBoard:
//         return motherBoard;
//       case PartsCategory.graphicsCard:
//         return graphicsCard;
//       case PartsCategory.ssd:
//         return ssd;
//       case PartsCategory.pcCase:
//         return pcCase;
//       case PartsCategory.powerUnit:
//         return powerUnit;
//       case PartsCategory.caseFan:
//         return caseFan;
//     }
//   }
// }

// class CustomNotifier extends StateNotifier<CustomOld> {
//   CustomNotifier(super.state);

//   void setCpu(PcParts cpu) {
//     state = state.copyWith(cpu: cpu);
//   }

//   void deleteCpu() {
//     state = state.copyWith(cpu: null);
//   }

//   void setCpuCooler(PcParts cpuCooler) {
//     state = state.copyWith(cpuCooler: cpuCooler);
//   }

//   void deleteCpuCooler() {
//     state = state.copyWith(cpuCooler: null);
//   }

//   void setMemory(PcParts memory) {
//     state = state.copyWith(memory: memory);
//   }

//   void deleteMemory() {
//     state = state.copyWith(memory: null);
//   }

//   void setMotherBoard(PcParts motherBoard) {
//     state = state.copyWith(motherBoard: motherBoard);
//   }

//   void deleteMotherBoard() {
//     state = state.copyWith(motherBoard: null);
//   }

//   void setGraphicsCard(PcParts graphicsCard) {
//     state = state.copyWith(graphicsCard: graphicsCard);
//   }

//   void deleteGraphicsCard() {
//     state = state.copyWith(graphicsCard: null);
//   }

//   void setSsd(PcParts ssd) {
//     state = state.copyWith(ssd: ssd);
//   }

//   void deleteSsd() {
//     state = state.copyWith(ssd: null);
//   }

//   void setPcCase(PcParts pcCase) {
//     state = state.copyWith(pcCase: pcCase);
//   }

//   void deletePcCase() {
//     state = state.copyWith(pcCase: null);
//   }

//   void setPowerUnit(PcParts powerUnit) {
//     state = state.copyWith(powerUnit: powerUnit);
//   }

//   void deletePowerUnit() {
//     state = state.copyWith(powerUnit: null);
//   }

//   void setCaseFan(PcParts caseFan) {
//     state = state.copyWith(caseFan: caseFan);
//   }

//   void deleteCaseFan() {
//     state = state.copyWith(caseFan: null);
//   }

//   void reset() {
//     state = CustomOld.create();
//   }

//   void setCustom(CustomOld custom) {
//     state = custom;
//   }

//   void addCompatibility(PartsCompatibility compatibility) {
//     state = state.addCompatibility(compatibility);
//   }
// }

// final customProviderOld = StateNotifierProvider<CustomNotifier, CustomOld>((ref) {
//   return CustomNotifier(CustomOld.create());
// });
