import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/search_parameter.dart';
import '../../providers/searching_category.dart';

class ParametersSelectDrawer extends ConsumerStatefulWidget {
  const ParametersSelectDrawer({super.key});

  @override
  ParametersSelectDrawerState createState() => ParametersSelectDrawerState();
}

class ParametersSelectDrawerState extends ConsumerState<ParametersSelectDrawer> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(searchingCategoryProvider);
    final alignParams = ref.watch(searchParameterNotifierProvider)![category]!.alignParameters();

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.manage_search_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 30,
                      ),
                      Text(
                        '絞り込み条件選択',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                for (final param in alignParams)
                  ExpansionTile(
                    title: Text(
                      param.keys.first,
                    ),
                    children: [
                      for (int i = 0; i < param.values.first.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            title: Text(param.values.first[i].name),
                            value: param.values.first[i].isSelect,
                            onChanged: (checked) {
                              // 選択した条件をURLのパラメータに追加して再検索
                              ref.read(searchParameterNotifierProvider.notifier).toggleParameterSelect(param.keys.first, i);
                              setState(() {});
                            },
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    // 選択した条件を全てクリア
                    ref.read(searchParameterNotifierProvider.notifier).clearSelectedParameter();
                    setState(() {});
                  },
                  child: const Text('選択中の条件をクリア'),
                ),
                // 戻るボタン
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('戻る'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
