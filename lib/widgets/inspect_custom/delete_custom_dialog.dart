import 'package:custom_pc/providers/editing_custom_id.dart';
import 'package:custom_pc/providers/stored_customs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteCustomDialog extends ConsumerWidget {
  const DeleteCustomDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainColor = Color.fromRGBO(60, 130, 80, 1);
    final customId = ref.watch(editingCustomIdNotifierProvider);
    return SimpleDialog(
      //contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'カスタムを削除しますか？',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'キャンセル',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '削除',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
