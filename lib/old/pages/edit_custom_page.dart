import 'package:custom_pc/old/providers/create_custom.dart';
import 'package:custom_pc/old/widgets/edit_custom/custom_summary_panel_widget.dart';
import 'package:custom_pc/old/widgets/edit_custom/parts_list_widget.dart';
import 'package:custom_pc/old/widgets/edit_custom/rename_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../config/size_config.dart';
import '../widgets/create_custom/save_confirm_dialog.dart';
import '../widgets/edit_custom/edit_cancel_dialog.dart';
import '../widgets/edit_custom/update_custom_dialog.dart';

class EditCustomPageOld extends ConsumerStatefulWidget {
  const EditCustomPageOld({super.key});

  @override
  EditCustomPageOldState createState() => EditCustomPageOldState();
}

class EditCustomPageOldState extends ConsumerState<ConsumerStatefulWidget> {
  final mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final surfaceColor = const Color(0xFFEDECF2);
  final onSurfaceColor = const Color.fromRGBO(14, 31, 18, 1);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String? customTitle = ref.watch(createCustomNotifierProvider).name;

    return Scaffold(
      backgroundColor: surfaceColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                customTitle ?? 'New Custom',
                style: TextStyle(
                  color: onSurfaceColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2,
            ),
            if (customTitle != null)
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return RenameCustomDialog(customTitle);
                    },
                  );
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
          if (customTitle != null)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return const UpdateCustomDialog();
                  },
                );
              },
              icon: Icon(
                Icons.check,
                color: mainColor,
              ),
            ),
          if (customTitle == null)
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return SaveConfirmDialog();
                    });
              },
              child: Icon(
                Icons.save_as_outlined,
                size: 35,
                color: mainColor,
              ),
            ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return const EditCancelDialog();
                },
              );
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
