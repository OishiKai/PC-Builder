import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/pages/edit_custom_page.dart';
import 'package:custom_pc/widgets/inspect_custom/delete_custom_dialog.dart';
import 'package:custom_pc/widgets/inspect_custom/summary_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/inspect_custom/parts_inspect_widget.dart';

class InspectCustomPage extends StatelessWidget {
  const InspectCustomPage(this.customId, {super.key});
  final String customId;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    return Scaffold(
        backgroundColor: const Color(0xFFEDECF2),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'タイトルなし',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCustomPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 30,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return DeleteCustomDialog(customId);
                          });
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            const SummaryWidget(),
            PartsInspectWidget(),
          ],
        ));
  }
}
