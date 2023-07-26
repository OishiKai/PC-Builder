import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/widgets/stored_custom_list/new_custom_bottom_bar.dart';
import 'package:custom_pc/widgets/stored_custom_list/stored_customs_table_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ライブラリ',
              style: TextStyle(
                fontSize: 24,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '保存済みカスタム',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.sort,
            color: mainColor,
            size: 32,
          ),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: StoredCustomsListWidget(),
      ),
      // floatingActionButton: SizedBox(
      //   width: SizeConfig.blockSizeHorizontal * 42,
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         PageRouteBuilder(
      //             pageBuilder: (context, animation, secondaryAnimation) => const CreateCustomPage(),
      //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //               return CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, linearTransition: false, child: child);
      //             }),
      //       );
      //     },
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     backgroundColor: mainColor,
      //     child: Row(
      //       children: const [
      //         SizedBox(
      //           width: 8,
      //         ),
      //         Icon(Icons.add),
      //         SizedBox(
      //           width: 4,
      //         ),
      //         Text(
      //           'NEW CUSTOM',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 14,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 8,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: const NewCustomBottomBar(),
    );
  }
}
