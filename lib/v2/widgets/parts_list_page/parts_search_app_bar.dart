import 'package:custom_pc/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class PartsSearchAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const PartsSearchAppBar({super.key});

  @override
  PartsSearchAppBarState createState() => PartsSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PartsSearchAppBarState extends ConsumerState<PartsSearchAppBar> {
  @override
  Widget build(BuildContext context) {
    final category = ref.watch(searchingCategoryProvider);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: TextField(
        controller: TextEditingController(text: ref.watch(searchTextProvider)),
        decoration: InputDecoration(
          hintText: '${category.categoryShortName}を検索',
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              ref.read(searchTextProvider.notifier).update((state) => '');
            },
          ),
        ),
        onSubmitted: (value) {
          if (value.trim() == '') return;
          ref.read(searchTextProvider.notifier).update((state) => value.trim());
        },
      ),
      actions: [
        Builder(
          builder: (context) => InkWell(
            // 絞り込み条件選択Drawerを開く
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Icon(
                    Icons.manage_search_outlined,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 30,
                  ),
                  Text(
                    '絞り込み',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
