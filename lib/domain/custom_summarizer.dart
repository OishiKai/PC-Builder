import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';

import '../models/custom_old.dart';
import '../widgets/custom_detail_page/summary_info_cell.dart';

class CustomSummarizer {
  static List<SummaryInfoCell> getSummaryWidgets(CustomOld custom, Brightness brightness) {
    // 各パーツのSummaryInfoCellを作成し、最後にnullを除く
    return [
      _summarizeCpu(custom.cpu, brightness),
      _summarizeCpuCooler(custom.cpuCooler, brightness),
      _summarizeMemory(custom.memory, brightness),
      _summarizeMotherboard(custom.motherBoard, brightness),
      _summarizeGraphicsCard(custom.graphicsCard, brightness),
      _summarizeSsd(custom.ssd, brightness),
      _summarizePowerUnit(custom.powerUnit, brightness),
    ].whereType<SummaryInfoCell>().toList();
  }

  static SummaryInfoCell? _summarizeCpu(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;

    const IconData icon = Icons.memory;

    return SummaryInfoCell(
      icon: icon,
      title: parts.title,
      category: PartsCategory.cpu,
    );
  }

  static SummaryInfoCell? _summarizeCpuCooler(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;

    final type = parts.specs!['タイプ']!;
    String? summaryType;
    IconData? icon;

    if (type == '水冷型') {
      summaryType = type;
      icon = Icons.water_drop_outlined;
    } else {
      summaryType = '空冷型';
      icon = Icons.air_rounded;
    }

    return SummaryInfoCell(
      icon: icon,
      title: summaryType,
      category: PartsCategory.cpuCooler,
    );
  }

  static SummaryInfoCell? _summarizeMemory(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.straighten;

    final volume = parts.specs!['メモリ容量(1枚あたり)'];
    final sheets = parts.specs!['枚数'];
    if (volume == null || sheets == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: '$volume × $sheets',
      category: PartsCategory.memory,
    );
  }

  static SummaryInfoCell? _summarizeMotherboard(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.dashboard_outlined;

    final title = parts.specs!['フォームファクタ'];
    if (title == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: title,
      category: PartsCategory.motherboard,
    );
  }

  static SummaryInfoCell? _summarizeGraphicsCard(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.wallpaper;

    return SummaryInfoCell(
      icon: icon,
      title: parts.specs!['搭載チップ']!.replaceAll('NVIDIA', '').replaceAll('AMD', ''),
      category: PartsCategory.graphicsCard,
    );
  }

  static SummaryInfoCell? _summarizeSsd(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.sd_card_outlined;

    final volume = parts.specs!['容量'];
    if (volume == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: volume,
      category: PartsCategory.ssd,
    );
  }

  static SummaryInfoCell? _summarizePowerUnit(PcPartsOld? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.power_outlined;

    final volume = parts.specs!['電源容量'];
    if (volume == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: volume,
      category: PartsCategory.powerUnit,
    );
  }
}
