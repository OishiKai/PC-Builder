import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/v2/custom_summarizer.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/size_config.dart';
import '../../models/custom.dart';

class CustomSummaryWidget extends StatefulWidget {
  const CustomSummaryWidget({super.key, required this.custom});
  final Custom custom;

  @override
  State<CustomSummaryWidget> createState() => _CustomSummaryWidgetState();
}

class _CustomSummaryWidgetState extends State<CustomSummaryWidget> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          if (cells.length > 1)
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
