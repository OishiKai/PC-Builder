import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/edit_custom.dart';

class CustomNameEditWidget extends ConsumerWidget {
  const CustomNameEditWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'カスタム名',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 26),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final controller = TextEditingController(text: custom.name);
                      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

                      // カスタム名入力ダイアログ
                      return SimpleDialog(
                        contentPadding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                TextField(
                                  controller: controller,
                                  maxLines: 1,
                                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                                  cursorColor: Theme.of(context).colorScheme.primary,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                                    ),
                                    labelText: 'カスタム名',
                                    labelStyle: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
                                  ),
                                  onSubmitted: (text) {
                                    ref.read(editCustomNotifierProvider.notifier).rename(text);
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'キャンセル',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        ref.read(editCustomNotifierProvider.notifier).rename(controller.text);
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                          '変更',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    custom.name ?? 'NEW CUSTOM',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
