import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteCustomDialog extends ConsumerWidget {
  const DeleteCustomDialog(this.customId, {super.key});
  final String customId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    return SimpleDialog(
      //contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'カスタムを削除しますか？',
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'キャンセル',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                ref.read(storedCustomsNotifierProvider.notifier).deleteCustom(customId);
                Navigator.pop(context, customId);
                Navigator.pop(context, customId);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '削除',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
