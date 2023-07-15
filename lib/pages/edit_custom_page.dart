import 'package:custom_pc/widgets/edit_custom/custom_summary_panel_widget.dart';
import 'package:custom_pc/widgets/edit_custom/parts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../config/size_config.dart';

class EditCustomPage extends StatelessWidget {
  const EditCustomPage({super.key});
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final surfaceColor = const Color(0xFFEDECF2);
  final onSurfaceColor = const Color.fromRGBO(14, 31, 18, 1);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: Text(
          'タイトル',
          style: TextStyle(
            color: onSurfaceColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: surfaceColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: onSurfaceColor,
            ),
          ),
        ],
      ),
      body: SlidingUpPanel(
        minHeight: SizeConfig.blockSizeVertical * 15,
        maxHeight: SizeConfig.blockSizeVertical * 60,
        //renderPanelSheet: false,
        border: Border(
          top: BorderSide(
            color: mainColor,
            width: 2.5,
          ),
        ),
        // borderRadius: BorderRadius.all(
        //   Radius.circular(20),
        // ),
        body: ListView(
          children: const [
            PartsListWidget(),
          ],
        ),
        panel: CustomSummaryPanelWidget(),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: mainColor,
      // )
    );
  }
}
