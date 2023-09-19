import 'package:clippy_flutter/arc.dart';
import 'package:custom_pc/models/detail_page_usage.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/providers/edit_custom.dart';
import 'package:custom_pc/providers/parts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../config/size_config.dart';
import '../providers/custom_repository.dart';
import '../widgets/parts_detail/edit_button_widget.dart';
import '../widgets/parts_detail/full_scale_image_slider.dart';
import '../widgets/parts_detail/select_for_create_button_widget.dart';
import '../widgets/parts_detail/shops_widget.dart';
import '../widgets/parts_detail/specs_widget.dart';
import '../widgets/parts_detail/star_widget.dart';

class PartsDetailPage extends ConsumerStatefulWidget {
  const PartsDetailPage({
    super.key,
    required this.usageValue,
    this.categoryName,
    this.customId,
    this.listIndex,
  });

  final String usageValue;
  final String? categoryName;
  final String? customId;
  final int? listIndex;

  @override
  ConsumerState<PartsDetailPage> createState() => _PartsDetailPageState();
}

class _PartsDetailPageState extends ConsumerState<PartsDetailPage> with SingleTickerProviderStateMixin {
  bool isHidden = false;
  int activeIndex = 0;

  final Map<int, Widget> _children = {
    0: const Text('販売店'),
    1: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text('詳細スペック'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    // final mainColor = ;
    final customs = ref.watch(customRepositoryNotifierProvider);
    // usageValueからDetailPageUsageを取得
    final usage = DetailPageUsage.fromString(widget.usageValue);
    int selectedIndex = 0;

    // 用途がview,editの場合はcategoryを指定
    Scaffold build(PcParts parts, PartsCategory? category) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: <Widget>[
            IndexedStack(
              index: selectedIndex,
              children: [
                ListView(
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
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    // 画像スライダー
                    FullScaleImageSlider(parts.fullScaleImages!),
                    Arc(
                      edge: Edge.TOP,
                      arcType: ArcType.CONVEY,
                      height: 30,
                      child: Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  parts.maker,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 16),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        parts.title,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
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
                                    parts.price.replaceFirst(' ～', ''),
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
                              SpecsWidgets(parts.specs!).generalSpecs(context),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                                child: MaterialSegmentedControl(
                                  children: _children,
                                  selectionIndex: activeIndex,
                                  selectedColor: Theme.of(context).colorScheme.primary,
                                  borderColor: Theme.of(context).colorScheme.primary,
                                  borderWidth: 2,
                                  selectedTextStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedTextStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedColor: Theme.of(context).colorScheme.surfaceVariant,
                                  onSegmentChosen: (index) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              if (activeIndex == 0) ShopsWidget(parts.shops!),
                              if (activeIndex == 1) SpecsWidgets(parts.specs!),
                              const SizedBox(
                                height: 120,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                height: SizeConfig.blockSizeVertical * 10,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (usage == DetailPageUsage.create) SelectForCreateButtonWidget(parts: parts),
                    if (usage == DetailPageUsage.edit) EditButtonWidget(category: category!),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (usage == DetailPageUsage.view) {
      // 閲覧用途の場合は、customIdからcustomを取得し、categoryでパーツを指定する
      final category = PartsCategory.fromCategoryName(widget.categoryName!);

      return customs.when(
        data: (data) {
          final custom = data.firstWhere((element) => element.id == widget.customId);
          final parts = custom.get(category)!;
          return build(parts, category);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())),
      );
    } else if (usage == DetailPageUsage.edit) {
      // 編集用途の場合は、editCustomNotifierProviderからcustomを取得し、categoryでパーツを指定する
      final category = PartsCategory.fromCategoryName(widget.categoryName!);
      final parts = ref.watch(editCustomNotifierProvider).get(category)!;
      return build(parts, category);
    } else {
      // 作成用途の場合は、partsListProviderからパーツを取得する
      final asyncParts = ref.watch(partsListProvider);
      return asyncParts.when(
        data: (data) {
          final parts = data[widget.listIndex!];
          return build(parts, null);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())),
      );
    }
  }
}
