import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme.dart';
import '../config/share_preferences_instance.dart';

class ThemeSettingWidget extends ConsumerWidget {
  const ThemeSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final prefs = SharedPreferencesInstance().prefs;
    const themeKey = 'theme';
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
            value: theme == ThemeMode.system,
            onChanged: (value) async {
              if (theme != ThemeMode.system) {
                ref.read(themeProvider.notifier).update((state) => ThemeMode.system);
                prefs.setString(themeKey, 'system');
              }
            },
          ),
          CheckboxListTile(
            title: const Text('ライトモード'),
            value: theme == ThemeMode.light,
            onChanged: (value) {
              if (theme != ThemeMode.light) {
                ref.read(themeProvider.notifier).update((state) => ThemeMode.light);
                prefs.setString(themeKey, 'light');
              }
            },
          ),
          CheckboxListTile(
            title: const Text('ダークモード'),
            value: theme == ThemeMode.dark,
            onChanged: (value) {
              if (theme != ThemeMode.dark) {
                ref.read(themeProvider.notifier).update((state) => ThemeMode.dark);
                prefs.setString(themeKey, 'dark');
              }
            },
          )
        ],
      ),
    );
  }
}
