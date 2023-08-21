import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoredCustomListWidget extends ConsumerWidget {
  const StoredCustomListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Stored Custom List'),
    );
  }
}
