import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/v2/widgets/summary_info_cell.dart';
import 'package:flutter/material.dart';

import '../models/custom.dart';

class CustomSummarizer {
  // final Map<String, Color> summaryColorLight = {
  //   'AMD': const Color(0xFFB5251C),
  //   'onAMD': const Color(0xFFFFFFFF),
  //   'intel': const Color(0xFF9EEFFF),
  //   'onIntel': const Color(0xFFFFFFFF),
  //   'NVIDIA': const Color(0xFF7CFF4B),
  //   'onNVIDIA': const Color(0xFFFFFFFF),
  //   'storage': Theme.of(context).colorScheme.primary,
  //   'onStorage': const Color(0xFFFFFFFF),
  // };
  //
  // final Map<String, Color> summaryColorDark = {
  //   'AMD': const Color(0xFFFFB4A9),
  //   'onAMD': const Color(0xFF690002),
  //   'intel': const Color(0xFF004E59),
  //   'onIntel': const Color(0xFF9EEFFF),
  //   'NVIDIA': const Color(0xFF175200),
  //   'onNVIDIA': const Color(0xFF7CFF4B),
  //   'storage': Theme.of(context).colorScheme.primary,
  //   'onStorage': Theme.of(context).colorScheme.onPrimary,
  // };

  static List<SummaryInfoCell> getSummaryWidgets(Custom custom, Brightness brightness) {
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

  static SummaryInfoCell? _summarizeCpu(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    const IconData icon = Icons.memory;
    Color? backgroundColor;
    Color? textColor;

    if (parts.maker.contains('AMD')) {
      backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
      textColor = brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF690002);
    } else if (parts.maker.contains('インテル')) {
      backgroundColor = brightness == Brightness.light ? const Color(0xFF9EEFFF) : const Color(0xFF004E59);
      textColor = brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF9EEFFF);
    }

    if (backgroundColor == null || textColor == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: parts.title,
      category: PartsCategory.cpu,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizeCpuCooler(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    final backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
    const textColor = Color(0xFFFFFFFF);

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
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizeMemory(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    final backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
    const textColor = Color(0xFFFFFFFF);
    const IconData icon = Icons.straighten;

    final volume = parts.specs!['メモリ容量(1枚あたり)'];
    final sheets = parts.specs!['枚数'];
    if (volume == null || sheets == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: '$volume × $sheets',
      category: PartsCategory.memory,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizeMotherboard(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    final backgroundColor = brightness == Brightness.light ? const Color(0xFF9EEFFF) : const Color(0xFF004E59);
    const textColor = Color(0xFFFFFFFF);
    const IconData icon = Icons.dashboard_outlined;

    final title = parts.specs!['フォームファクタ'];
    if (title == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: title,
      category: PartsCategory.motherboard,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizeGraphicsCard(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;
    const IconData icon = Icons.wallpaper;

    Color? backgroundColor;
    Color? textColor;

    // AMD or NVIDIA で色変える
    if (parts.specs!['搭載チップ']!.contains('AMD')) {
      backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
      textColor = brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF690002);
    } else if (parts.specs!['搭載チップ']!.contains('NVIDIA')) {
      backgroundColor = brightness == Brightness.light ? const Color(0xFF7CFF4B) : const Color(0xFF175200);
      textColor = brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFF7CFF4B);
    }
    if (backgroundColor == null || textColor == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: parts.specs!['搭載チップ']!.replaceAll('NVIDIA', '').replaceAll('AMD', ''),
      category: PartsCategory.graphicsCard,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizeSsd(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    final backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
    const textColor = Color(0xFFFFFFFF);
    const IconData icon = Icons.sd_card_outlined;

    final volume = parts.specs!['容量'];
    if (volume == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: volume,
      category: PartsCategory.ssd,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  static SummaryInfoCell? _summarizePowerUnit(PcParts? parts, Brightness brightness) {
    if (parts == null) return null;

    final backgroundColor = brightness == Brightness.light ? const Color(0xFFB5251C) : const Color(0xFFFFB4A9);
    const textColor = Color(0xFFFFFFFF);
    const IconData icon = Icons.power_outlined;

    final volume = parts.specs!['電源容量'];
    if (volume == null) return null;

    return SummaryInfoCell(
      icon: icon,
      title: volume,
      category: PartsCategory.powerUnit,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
