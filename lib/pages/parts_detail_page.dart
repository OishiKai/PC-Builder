import 'package:clippy_flutter/arc.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../config/size_config.dart';
import '../providers/create_custom.dart';
import '../providers/searching_category.dart';
import '../widgets/parts_detail/full_scale_image_slider.dart';
import '../widgets/parts_detail/shops_widget.dart';
import '../widgets/parts_detail/specs_widget.dart';
import '../widgets/parts_detail/star_widget.dart';

// 販売店 or 詳細スペック の表示状態 (デフォルトは 0)
final detailPageProvider = StateProvider<int>((ref) {
  return 0;
});

class PartsDetailPage extends ConsumerStatefulWidget {
  const PartsDetailPage(this.parts, this.isEditing, {super.key});
  final PcParts parts;
  final bool isEditing;
  @override
  ConsumerState<PartsDetailPage> createState() => _PartsDetailPageState();
}

class _PartsDetailPageState extends ConsumerState<PartsDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _height;
  late ScrollController _scrollController;

  bool isHidden = false;
  int _selectedIndex = 0;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _selectedIndex,
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
                            SpecsWidgets(widget.parts.specs!).generalSpecs(),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final category = ref.read(searchingCategoryProvider);
                            ref.read(createCustomNotifierProvider.notifier).setParts(category, widget.parts);
                            int count = 0;
                            ref.read(createCustomNotifierProvider.notifier).updateCompatibilities();
                            Navigator.popUntil(context, (_) => count++ >= 2);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color.fromRGBO(60, 130, 80, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            side: BorderSide(
                              color: Colors.green,
                              width: 5,
                            ),
                          ),
                          child: Row(
                            children: const [
                              Spacer(),
                              Text(
                                "このパーツを選択する",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
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
