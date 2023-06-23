import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/widgets/stored_custom_list/custom_cell.dart';
import 'package:flutter/material.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 6),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.tune_sharp,
                      size: 35,
                      color: mainColor,
                    ),
                  ),
                  const Spacer(),
                  Column(
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
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.more_vert_outlined,
                      size: 35,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(top: 16),
              height: SizeConfig.blockSizeVertical * 78,
              decoration: BoxDecoration(
                color: const Color(0xFFEDECF2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0; i < 30; i++) CustomCellWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 42,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: mainColor,
          child: Row(
            children: const [
              SizedBox(
                width: 8,
              ),
              Icon(Icons.add),
              SizedBox(
                width: 4,
              ),
              Text(
                'NEW CUSTOM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: SizeConfig.blockSizeVertical * 8,
        decoration: BoxDecoration(
          color: mainColor,
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   topRight: Radius.circular(40),
          // ),
        ),
      ),
    );
  }
}
