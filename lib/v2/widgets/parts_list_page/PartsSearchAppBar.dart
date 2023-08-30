import 'package:custom_pc/v2/providers/searching_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartsSearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PartsSearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(searchingCategoryProviderV2);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: TextField(
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
          prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {},
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ),
      ),
      actions: [
        Builder(
          builder: (context) => InkWell(
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
