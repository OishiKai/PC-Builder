import 'package:custom_pc/v2/providers/edit_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCustomPageV2 extends ConsumerWidget {
  const EditCustomPageV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final custom = ref.watch(editCustomNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(custom.name ?? 'New Custom'),
      ),
      body: const Center(
        child: Text('Edit Custom Page'),
      ),
    );
  }
}
