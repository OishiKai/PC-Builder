import 'package:custom_pc/providers/create_custom.dart';
import 'package:custom_pc/widgets/edit_custom/custom_summary_panel_widget.dart';
import 'package:custom_pc/widgets/edit_custom/parts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../config/size_config.dart';

class EditCustomPage extends ConsumerStatefulWidget {
  const EditCustomPage({super.key});

  @override
  EditCustomPageState createState() => EditCustomPageState();
}

class EditCustomPageState extends ConsumerState<ConsumerStatefulWidget> {
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final surfaceColor = const Color(0xFFEDECF2);
  final onSurfaceColor = const Color.fromRGBO(14, 31, 18, 1);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String customTitle = ref.watch(createCustomNotifierProvider).name!;
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              customTitle,
              style: TextStyle(
                color: onSurfaceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.edit,
                color: onSurfaceColor,
              ),
            ),
          ],
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
              Icons.check,
              color: mainColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
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
        body: ListView(
          children: const [
            PartsListWidget(),
          ],
        ),
        panel: const CustomSummaryPanelWidget(),
      ),
    );
  }
}
