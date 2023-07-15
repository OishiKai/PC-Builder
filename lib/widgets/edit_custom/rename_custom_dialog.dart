import 'package:custom_pc/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/create_custom.dart';

class RenameCustomDialog extends ConsumerStatefulWidget {
  const RenameCustomDialog(this.storedName, {super.key});
  final String storedName;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RenameCustomDialogState();
}

class _RenameCustomDialogState extends ConsumerState<RenameCustomDialog> {
  String customName = '';
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    customName = widget.storedName;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final custom = ref.watch(createCustomNotifierProvider);
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    // String customName = widget.storedName;
    void handleText(String e) {
      setState(() {
        customName = e;
      });
      print(customName);
    }

    _controller.text = customName;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));

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
                'カスタム名を編集',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: handleText,
                maxLines: 1,
                maxLength: 15,
                cursorColor: mainColor,
                style: const TextStyle(color: Colors.black),
                controller: _controller,
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
                      ref.read(createCustomNotifierProvider.notifier).rename(customName);
                      Navigator.pop(context);
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
