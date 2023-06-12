import 'package:custom_pc/domain/url_builder.dart';
import 'package:custom_pc/main.dart';
import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider<String>((ref) {
  return '';
});

class PartsListAppBar extends ConsumerWidget implements PreferredSizeWidget {
  PartsListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: ref.watch(searchTextProvider));
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    return WillPopScope(
      onWillPop: () async {
        ref.read(searchTextProvider.notifier).update((state) => '');
        return true;
      },
      child: AppBar(
        backgroundColor: Color.fromRGBO(60, 130, 80, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        title: SizedBox(
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEDECF2),
              border: Border.all(color: Color.fromRGBO(60, 130, 80, 1)),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Container(
                width: 340,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(left: 8.0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                  ),
                  onSubmitted: (text) {
                    final trimText = text.trim();
                    if (trimText == '' || trimText == '　') {
                      return;
                    }
                    final url = UrlBuilder.searchPartsList(PartsCategory.graphicsCard, trimText);
                    //ref.read(targetUrlProvider.notifier).update((state) => url);
                    ref.read(searchTextProvider.notifier).update((state) => text);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
