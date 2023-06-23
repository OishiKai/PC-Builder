import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/database/custom_repository.dart';
import '../../providers/create_custom.dart';

class SaveConfirmDialog extends ConsumerStatefulWidget {
  SaveConfirmDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveConfirmDialogState();
}

class _SaveConfirmDialogState extends ConsumerState<SaveConfirmDialog> {
  String _customName = 'タイトルなし';

  void _handleText(String e) {
    setState(() {
      _customName = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);
    const mainColor = Color.fromRGBO(60, 130, 80, 1);

    // パーツを選択していない場合
    if (custom.isEmpty()) {
      return SimpleDialog(
        backgroundColor: mainColor,
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEDECF2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'パーツを選択してください',
                  style: TextStyle(
                    fontSize: 18,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 20),
                    child: const Text('OK'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // 一つ以上パーツを選択している場合
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFEDECF2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                '保存する',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: _handleText,
                maxLines: 1,
                maxLength: 15,
                cursorColor: mainColor,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 2),
                  ),
                  labelText: 'カスタム名',
                  labelStyle: TextStyle(color: mainColor),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('キャンセル'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      final namedCustom = custom.copyWith(name: _customName);
                      CustomRepository.insertCustom(namedCustom);
                      ref.read(createCustomNotifierProvider.notifier).reset();
                      int count = 0;
                      Navigator.popUntil(context, (_) => count++ >= 2);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('保存'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
