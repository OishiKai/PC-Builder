import 'package:custom_pc/config/size_config.dart';
import 'package:custom_pc/pages/edit_custom_page.dart';
import 'package:custom_pc/providers/detail_page_usage.dart';
import 'package:custom_pc/providers/editing_custom_id.dart';
import 'package:custom_pc/providers/stored_customs.dart';
import 'package:custom_pc/widgets/inspect_custom/delete_custom_dialog.dart';
import 'package:custom_pc/widgets/inspect_custom/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/custom.dart';
import '../providers/create_custom.dart';
import '../widgets/inspect_custom/parts_inspect_widget.dart';

class InspectCustomPage extends ConsumerWidget {
  const InspectCustomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    final customId = ref.watch(editingCustomIdNotifierProvider);
    final storedCustomList = ref.watch(storedCustomsNotifierProvider);

    Custom? custom;
    storedCustomList.when(
      data: (data) {
        custom = data[customId];
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (Object error, StackTrace stackTrace) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    return Scaffold(
        backgroundColor: const Color(0xFFEDECF2),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 2, left: 16, right: 16),
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
                        child: Text(
                          custom?.name! ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(createCustomNotifierProvider.notifier).reset();
                        ref.read(createCustomNotifierProvider.notifier).updateState(custom!);
                        ref.read(createCustomNotifierProvider.notifier).updateCompatibilities();
                        ref.read(detailPageUsageNotifierProvider.notifier).switchEdit();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditCustomPage(),
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
                              return const DeleteCustomDialog();
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
              if (custom != null) SummaryWidget(custom),
              if (custom != null) PartsInspectWidget(custom!),
            ],
          ),
        ));
  }
}
