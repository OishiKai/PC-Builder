import 'package:clippy_flutter/arc.dart';
import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../main.dart';
import 'detail_bottom_bar.dart';
import 'full_scale_image_slider.dart';

final detailPageProvider = StateProvider<int>((ref) {
  return 0;
});

class PartsDetailPage extends ConsumerWidget {
  PartsDetailPage(this.partsListIndex, this.stars, {Key? key})
      : super(key: key);

  int partsListIndex;
  int activeIndex = 0;

  final Map<int, Widget> _children = {
    0: const Text('販売店'),
    1: const Text("　詳細スペック  "),
  };

  Color mainColor = Color.fromRGBO(60, 130, 80, 1);
  int _currentSelection = 0;
  List<Icon> stars;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final listProvider = ref.watch(partsListProvider);
    if (listProvider == null) {
      return Scaffold();
    }
    final targetParts = listProvider[partsListIndex];
    _currentSelection = ref.watch(detailPageProvider);

    List<Container> specs = [];
    targetParts.specs?.forEach((key, value) {
      if (value != null && value != '　') {
        specs.add(Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.b,
                children: [
                  Icon(
                    Icons.info,
                    size: 18,
                    color: mainColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    key,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            color: Color(0xFFEDECF2),
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: mainColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Product",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 25,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: FullScaleImageSlider(targetParts.fullScaleImages!),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Color(0xFFEDECF2),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        targetParts.maker,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              targetParts.title,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Row(
                            children: stars,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          targetParts.price.replaceFirst(' ～', ''),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    specs[0],
                    specs[1],
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFEDECF2),
                      ),
                      child: MaterialSegmentedControl(
                        children: _children,
                        selectionIndex: _currentSelection,
                        selectedColor: mainColor,
                        borderColor: mainColor,
                        borderWidth: 2,
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedColor: Colors.grey,
                        onSegmentChosen: (index) {
                          ref
                              .read(detailPageProvider.notifier)
                              .update((state) => index);
                        },
                      ),
                    ),
                    if (_currentSelection == 0)
                      for (int i = 0; i < targetParts.shops!.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: mainColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: mainColor,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  targetParts.shops![i].shopName,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  targetParts.shops![i].price,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  color: mainColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                    if (_currentSelection == 1)
                      for (int i = 2; i < specs.length; i++) specs[i],
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: DetailBottomBar(),
    );
  }
}
