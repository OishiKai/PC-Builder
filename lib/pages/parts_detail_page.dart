import 'package:clippy_flutter/arc.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/providers/detail_page_usage.dart';
import 'package:custom_pc/widgets/parts_detail/select_for_create_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../config/size_config.dart';
import '../widgets/parts_detail/full_scale_image_slider.dart';
import '../widgets/parts_detail/shops_widget.dart';
import '../widgets/parts_detail/specs_widget.dart';
import '../widgets/parts_detail/star_widget.dart';

// 販売店 or 詳細スペック の表示状態 (デフォルトは 0)
final detailPageProvider = StateProvider<int>((ref) {
  return 0;
});

class PartsDetailPageOld extends ConsumerStatefulWidget {
  const PartsDetailPageOld(this.parts, {super.key});
  final PcParts parts;
  @override
  ConsumerState<PartsDetailPageOld> createState() => _PartsDetailPageOldState();
}

class _PartsDetailPageOldState extends ConsumerState<PartsDetailPageOld> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _height;
  late ScrollController _scrollController;

  bool isHidden = false;

  final Map<int, Widget> _children = {
    0: const Text('販売店'),
    1: const Text("　詳細スペック  　"),
  };
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _height = Tween<double>(begin: 0, end: SizeConfig.blockSizeVertical * 10).animate(_animationController);

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          if (!isHidden) {
            _animationController.forward();
            isHidden = true;
          }
        } else {
          if (isHidden) {
            _animationController.reverse();
            isHidden = false;
          }
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int selectedIndex = 0;
    final usage = ref.watch(detailPageUsageNotifierProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: selectedIndex,
            children: [
              ListView(
                controller: _scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 35,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: FullScaleImageSlider(widget.parts.fullScaleImages!),
                  ),
                  Arc(
                    edge: Edge.TOP,
                    arcType: ArcType.CONVEY,
                    height: 30,
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFFEDECF2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                widget.parts.maker,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: mainColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.parts.title,
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: StarWidget(45),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  widget.parts.price.replaceFirst(' ～', ''),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SpecsWidgets(widget.parts.specs!).generalSpecs(context),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDECF2),
                              ),
                              child: MaterialSegmentedControl(
                                children: _children,
                                selectionIndex: ref.watch(detailPageProvider),
                                selectedColor: mainColor,
                                borderColor: mainColor,
                                borderWidth: 2,
                                selectedTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedColor: Colors.grey,
                                onSegmentChosen: (index) {
                                  ref.read(detailPageProvider.notifier).update((state) => index);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (ref.watch(detailPageProvider) == 0) ShopsWidget(widget.parts.shops!),
                            if (ref.watch(detailPageProvider) == 1) SpecsWidgets(widget.parts.specs!),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _height,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(0, _height.value),
                  child: Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    height: SizeConfig.blockSizeVertical * 10,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (usage == DetailPageUsage.create) SelectForCreateButtonWidget(parts: widget.parts),
                        // if (usage == DetailPageUsage.edit) const EditButtonWidget(category: ,),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
