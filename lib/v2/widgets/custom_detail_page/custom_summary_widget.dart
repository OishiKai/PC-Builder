import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/v2/custom_summarizer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/custom.dart';

/// CustomのSummaryを表示するWidget
class CustomSummaryWidget extends StatefulWidget {
  const CustomSummaryWidget({super.key, required this.custom});
  final Custom custom;

  @override
  State<CustomSummaryWidget> createState() => _CustomSummaryWidgetState();
}

class _CustomSummaryWidgetState extends State<CustomSummaryWidget> {
  // CarouselSliderで表示中のindex
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    // SummaryInfoCellのリストを取得
    final cells = CustomSummarizer.getSummaryWidgets(widget.custom, MediaQuery.platformBrightnessOf(context));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: cells.length > 2 ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.55,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onScrolled: (index) {
                activeIndex = index!.round();
                setState(() {});
              },
            ),
            // 1ページあたり最大4つのSummaryInfoCellを表示
            itemCount: cells.length % 4 == 0 ? cells.length ~/ 4 : cells.length ~/ 4 + 1,
            itemBuilder: (context, index, realIndex) {
              return GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  for (int i = index * 4; i < (index * 4 + 4 > cells.length ? cells.length : index * 4 + 4); i++) cells[i],
                ],
              );
            },
          ),
          // 5つ以上のSummaryInfoCellがある場合(2ページ以上ある)は、ページインジケーターを表示
          if (cells.length > 5)
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: cells.length % 4 == 0 ? cells.length ~/ 4 : cells.length ~/ 4 + 1,
              effect: JumpingDotEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}
