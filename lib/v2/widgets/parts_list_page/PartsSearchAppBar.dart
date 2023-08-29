import 'package:custom_pc/v2/providers/searching_category.dart';
import 'package:custom_pc/v2/widgets/parts_list_page/add_parameters_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartsSearchAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PartsSearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(searchingCategoryProviderV2);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(20),
      //     bottomRight: Radius.circular(20),
      //   ),
      // ),
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
      actions: const [
        AddParametersWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
