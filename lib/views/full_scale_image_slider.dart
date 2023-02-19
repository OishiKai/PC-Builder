import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_pc/domain/detail_parser.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FullScaleImageSlider extends StatefulWidget {
  FullScaleImageSlider(this.imageUrlList, {Key? key}) : super(key: key);
  List<String> imageUrlList;
  @override
  State<FullScaleImageSlider> createState() => _FullScaleImageSliderState();
}

class _FullScaleImageSliderState extends State<FullScaleImageSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 320,
            initialPage: 0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) => setState(() {
              activeIndex = index;
            }),
          ),
          itemCount: widget.imageUrlList.length,
          itemBuilder: (context, index, realIndex) {
            final path = widget.imageUrlList[index];
            return buildImage(path, index);
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 300,),
              buildIndicator(),
            ],
          ),
        )
      ],
    );
  }

  Widget buildImage(path, index) => Container(
    //画像間の隙間
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.white,
    child: Image.network(
      path,
      fit: BoxFit.contain,
    ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.imageUrlList.length ?? 0,
    effect: const JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Colors.grey,
        dotColor: Colors.black12),
  );
}
