import 'package:custom_pc/main.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/pages/parts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/size_config.dart';
import '../../domain/search_parameter_parser/case_fan_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_cooler_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/cpu_search_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/graphics_card_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/memory_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/mother_board_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/pc_case_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/power_unit_search_parameter_parser.dart';
import '../../domain/search_parameter_parser/ssd_search_parameter_parser.dart';

class PartsScrollWidget extends ConsumerWidget {
  PartsScrollWidget({super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);

    setupToPartsListPage(PartsCategory category) async {
      switch (category) {
        case PartsCategory.cpu:
          ref.read(targetUrlProvider.notifier).update((state) => CpuSearchParameterParser.standardPage);
          final param = await CpuSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.cpuCooler:
          ref.read(targetUrlProvider.notifier).update((state) => CpuCoolerSearchParameterParser.standardPage);
          final param = await CpuCoolerSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.memory:
          ref.read(targetUrlProvider.notifier).update((state) => MemorySearchParameterParser.standardPage);
          final param = await MemorySearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.motherBoard:
          ref.read(targetUrlProvider.notifier).update((state) => MotherBoardSearchParameterParser.standardPage);
          final param = await MotherBoardSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.graphicsCard:
          ref.read(targetUrlProvider.notifier).update((state) => GraphicsCardSearchParameterParser.standardPage);
          final param = await GraphicsCardSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.ssd:
          ref.read(targetUrlProvider.notifier).update((state) => SsdSearchParameterParser.standardPage);
          final param = await SsdSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.pcCase:
          ref.read(targetUrlProvider.notifier).update((state) => PcCaseSearchParameterParser.standardPage);
          final param = await PcCaseSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.powerUnit:
          ref.read(targetUrlProvider.notifier).update((state) => PowerUnitSearchParameterParser.standardPage);
          final param = await PowerUnitSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
        case PartsCategory.caseFan:
          ref.read(targetUrlProvider.notifier).update((state) => CaseFanSearchParameterParser.standardPage);
          final param = await CaseFanSearchParameterParser.fetchSearchParameter();
          ref.read(searchParameterProvider.notifier).update((state) => param);
          break;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 4,
          ),
          for (int i = 0; i < PartsCategory.values.length; i++)
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
              child: InkWell(
                onTap: () async {
                  setupToPartsListPage(PartsCategory.values[i]);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PartsListPage()));
                },
                child: Container(
                  // 4%, 28%, 4%, 28%, 4%, 28%, 4% の横幅で表示する
                  width: SizeConfig.blockSizeHorizontal * 28,
                  // 横幅の1.3倍の縦幅とする
                  height: SizeConfig.blockSizeHorizontal * 28 * 1.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          _shortName(PartsCategory.values[i]),
                          style: TextStyle(
                            //fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _mainColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.add_circle,
                        size: 30,
                        color: _mainColor,
                      ),
                      const Spacer(),
                      const Text(
                        '¥-',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  String _shortName(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return category.categoryName;
      case PartsCategory.cpuCooler:
        return 'CPUクーラー';
      case PartsCategory.memory:
        return 'メモリ';
      case PartsCategory.motherBoard:
        return 'マザボ';
      case PartsCategory.graphicsCard:
        return 'グラボ';
      case PartsCategory.ssd:
        return category.categoryName;
      case PartsCategory.pcCase:
        return category.categoryName;
      case PartsCategory.powerUnit:
        return '電源';
      case PartsCategory.caseFan:
        return category.categoryName;
    }
  }
}
