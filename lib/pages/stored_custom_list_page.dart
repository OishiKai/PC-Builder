import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';

class StoredCustomListPage extends StatelessWidget {
  const StoredCustomListPage({Key? key}) : super(key: key);
  //final Custom custom;

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
                const Text(
                  '見積もりリスト',
                  style: TextStyle(
                    fontSize: 20,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
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
              height: SizeConfig.blockSizeVertical * 80,
              padding: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: const Color(0xFFEDECF2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        backgroundColor: const Color(0xFFEDECF2),
                        collapsedIconColor: mainColor,
                        iconColor: mainColor,
                        //collapsedBackgroundColor: Colors.redAccent,
                        collapsedTextColor: Colors.blue,
                        title: Row(
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              size: 30,
                              color: mainColor,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'あああああああああああああああ',
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Text(
                                  '2021/09/01',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: const [
                          ListTile(
                            title: Text(
                              'CPU',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        backgroundColor: const Color(0xFFEDECF2),
                        //collapsedIconColor: mainColor,
                        //collapsedBackgroundColor: Colors.redAccent,
                        collapsedTextColor: Colors.blue,
                        title: Row(
                          children: const [
                            Icon(
                              Icons.storage_sharp,
                              size: 30,
                              color: mainColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'カスタム名',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '¥ 100,000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                        children: const [
                          ListTile(
                            title: Text(
                              'CPU',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
