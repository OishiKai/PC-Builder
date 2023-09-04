import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme.dart' as th;

class ThemeSettingWidget extends ConsumerWidget {
  const ThemeSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(th.themeProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'テーマ設定',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('システムの設定'),
            value: theme == th.ThemeMode.followSystem,
            onChanged: (value) {
              if (theme != th.ThemeMode.followSystem) {
                ref.read(th.themeProvider.notifier).update((state) => th.ThemeMode.followSystem);
              }
            },
          ),
          CheckboxListTile(
            title: const Text('ライトモード'),
            value: theme == th.ThemeMode.light,
            onChanged: (value) {
              if (theme != th.ThemeMode.light) {
                ref.read(th.themeProvider.notifier).update((state) => th.ThemeMode.light);
              }
            },
          ),
          CheckboxListTile(
            title: const Text('ダークモード'),
            value: theme == th.ThemeMode.dark,
            onChanged: (value) {
              if (theme != th.ThemeMode.dark) {
                ref.read(th.themeProvider.notifier).update((state) => th.ThemeMode.dark);
              }
            },
          )
        ],
      ),
    );
  }
}
