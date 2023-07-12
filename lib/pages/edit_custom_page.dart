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
          minHeight: 100,
          // borderRadius: const BorderRadius.only(
          //     // topLeft: Radius.circular(24),
          //     // topRight: Radius.circular(24),
          //     ),
          border: Border(
            top: BorderSide(
              color: mainColor,
              width: 3,
            ),
          ),
          body: ListView(
            children: const [
              PartsListWidget(),
            ],
          ),
          panel: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: SizeConfig.blockSizeVertical * 3,
                  alignment: Alignment.topCenter,
                  child: const Icon(
                    Icons.menu,
                    color: const Color.fromRGBO(9, 109, 54, 1),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 10,
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      //color: const Color.fromRGBO(157, 246, 176, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '¥0,000,000',
                      style: TextStyle(
                        color: const Color.fromRGBO(9, 109, 54, 1),
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: mainColor,
        ));
  }
}
