import 'package:flutter/material.dart';

import '../models/custom.dart';
import '../models/parts_category.dart';
import '../models/pc_parts.dart';
import '../widgets/custom_detail_page/summary_info_cell.dart';

class CustomSummarizer {
  static List<SummaryInfoCell> getSummaryWidgets(Custom custom, Brightness brightness) {
    // 各パーツのSummaryInfoCellを作成し、最後にnullを除く
    return [
      _summarizeCpu(custom.get(PartsCategory.cpu), brightness),
      _summarizeCpuCooler(custom.get(PartsCategory.cpuCooler), brightness),
      _summarizeMemory(custom.get(PartsCategory.memory), brightness),
      _summarizeMotherboard(custom.get(PartsCategory.motherboard), brightness),
      _summarizeGraphicsCard(custom.get(PartsCategory.graphicsCard), brightness),
      _summarizeSsd(custom.get(PartsCategory.ssd), brightness),
      _summarizePowerUnit(custom.get(PartsCategory.powerUnit), brightness),
    ].whereType<SummaryInfoCell>().toList();
  }

  static SummaryInfoCell? _summarizeCpu(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    const IconData icon = Icons.memory;

    return SummaryInfoCell(
      icon: icon,
      title: parts.title,
      category: PartsCategory.cpu,
    );
  }

  static SummaryInfoCell? _summarizeCpuCooler(PcParts? parts, Brightness brightness) {
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

  static SummaryInfoCell? _summarizeMemory(PcParts? parts, Brightness brightness) {
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

  static SummaryInfoCell? _summarizeMotherboard(PcParts? parts, Brightness brightness) {
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

  static SummaryInfoCell? _summarizeGraphicsCard(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.wallpaper;

    return SummaryInfoCell(
      icon: icon,
      title: parts.specs!['搭載チップ']!.replaceAll('NVIDIA', '').replaceAll('AMD', ''),
      category: PartsCategory.graphicsCard,
    );
  }

  static SummaryInfoCell? _summarizeSsd(PcParts? parts, Brightness brightness) {
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

  static SummaryInfoCell? _summarizePowerUnit(PcParts? parts, Brightness brightness) {
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
