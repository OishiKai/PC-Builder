import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/custom.dart';

class SummaryWidget extends ConsumerStatefulWidget {
  const SummaryWidget(this.custom, {super.key});
  final custom;
  @override
  ConsumerState<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends ConsumerState<SummaryWidget> {
  //final Custom custom;
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    final cells = summaryCells(widget.custom);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SUMMARY',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              Text(
                formatPrice(widget.custom.calculateTotalPrice()),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (cells.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: cells[0].length > 2 ? SizeConfig.blockSizeHorizontal * 93 : SizeConfig.blockSizeHorizontal * 45,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onScrolled: (index) {
                  activeIndex = index!.round();
                  setState(() {});
                },
              ),
              items: [
                for (int i = 0; i < cells.length; i++) summarySlider(cells[i]),
              ],
            ),
          const SizedBox(
            height: 8,
          ),
          if (cells.length > 1)
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: cells.length,
              effect: const JumpingDotEffect(dotHeight: 10, dotWidth: 10, activeDotColor: Color.fromRGBO(60, 130, 80, 1), dotColor: Colors.black12),
            ),
        ],
      ),
    );
  }

  List<List<Widget>> summaryCells(Custom custom) {
    List<Widget> cells = [];
    // 各カテゴリ別のsummaryウィジェットを作成
    custom.align().forEach((key, value) {
      if (key == PartsCategory.cpu) {
        Color cellColor = const Color.fromRGBO(60, 130, 80, 1);
        if (value.maker.contains('AMD')) cellColor = Colors.red[900]!;
        if (value.maker.contains('インテル')) cellColor = Colors.cyan[600]!;
        cells.add(generateCell(Icons.memory, value.specs!['プロセッサ名']!.split('(')[0], key, cellColor));
      }

      if (key == PartsCategory.graphicsCard) {
        Color cellColor = const Color.fromRGBO(60, 130, 80, 1);
        if (value.specs!['搭載チップ']!.contains('AMD')) cellColor = Colors.red[900]!;
        if (value.specs!['搭載チップ']!.contains('NVIDIA')) cellColor = Colors.lightGreenAccent[700]!;
        cells.add(generateCell(Icons.wallpaper, value.specs!['搭載チップ']!.replaceAll('NVIDIA', '').replaceAll('AMD', ''), key, cellColor));
      }

      if (key == PartsCategory.cpuCooler) {
        final type = value.specs!['タイプ']!;
        String summaryType = '';
        IconData? icon;
        if (type == '水冷型') {
          summaryType = type;
          icon = Icons.water_drop_outlined;
        } else {
          summaryType = '空冷型';
          icon = Icons.air_rounded;
        }
        cells.add(generateCell(icon, summaryType, key, Colors.blue[200]!));
      }

      if (key == PartsCategory.memory) {
        final volume = value.specs!['メモリ容量(1枚あたり)']!;
        final sheets = value.specs!['枚数']!;
        cells.add(generateCell(Icons.straighten, '$volume × $sheets', key, const Color.fromRGBO(60, 130, 80, 1)));
      }

      if (key == PartsCategory.motherboard) {
        final type = value.specs!['フォームファクタ']!;
        cells.add(generateCell(Icons.dashboard_outlined, type, key, Colors.black38));
      }

      if (key == PartsCategory.ssd) {
        final volume = value.specs!['容量']!;
        cells.add(generateCell(Icons.sd_card_outlined, volume, key, const Color.fromRGBO(60, 130, 80, 1)));
      }

      if (key == PartsCategory.powerUnit) {
        final volume = value.specs!['電源容量']!;
        cells.add(generateCell(Icons.power_outlined, volume, key, Colors.black38));
      }
    });
    List<List<Widget>> divided = [];
    List<Widget> set = [];
    // 1セット4つのウィジェットに分割
    for (int i = 0; i < cells.length; i++) {
      set.add(cells[i]);

      if ((i + 1) % 4 == 0 || i == cells.length - 1) {
        divided.add(List.from(set));
        set.clear();
      }
    }
    return divided;
  }

  Widget generateCell(IconData icon, String value, PartsCategory category, Color color) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              category.categoryShortName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summarySlider(List<Widget> cells) {
    return SizedBox(
      child: GridView.count(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          for (int i = 0; i < cells.length; i++) cells[i],
        ],
      ),
    );
  }

  String formatPrice(int value) {
    final String stringValue = value.toString();
    final StringBuffer buffer = StringBuffer();

    buffer.write('¥');

    for (int i = 0; i < stringValue.length; i++) {
      if (i > 0 && (stringValue.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(stringValue[i]);
    }

    return buffer.toString();
  }
}
