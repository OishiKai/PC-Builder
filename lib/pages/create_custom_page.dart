import 'package:custom_pc/widgets/create_custom/parts_scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/size_config.dart';

class CreateCustomPage extends ConsumerWidget {
  const CreateCustomPage({Key? key}) : super(key: key);

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: _mainColor,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'NEW CUSTOM',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _mainColor,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          PartsScrollWidget(),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: SizeConfig.blockSizeHorizontal * 4,
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 4),
          //         child: InkWell(
          //           onTap: () async {},
          //           child: Container(
          //             // 4%, 28%, 4%, 28%, 4%, 28%, 4% の横幅で表示する
          //             width: SizeConfig.blockSizeHorizontal * 28,
          //             // 横幅の1.3倍の縦幅とする
          //             height: SizeConfig.blockSizeHorizontal * 28 * 1.3,
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 const SizedBox(
          //                   height: 2,
          //                 ),
          //                 Text(
          //                   'CPU',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.bold,
          //                     color: _mainColor,
          //                   ),
          //                 ),
          //                 const Spacer(),
          //                 Icon(
          //                   Icons.add_circle,
          //                   size: 30,
          //                   color: _mainColor,
          //                 ),
          //                 const Spacer(),
          //                 const Text(
          //                   '¥-',
          //                   style: TextStyle(fontSize: 18, color: Colors.grey),
          //                 ),
          //                 const SizedBox(
          //                   height: 2,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 16,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, right: 16),
          //   child: Divider(
          //     thickness: 1,
          //     color: _mainColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
