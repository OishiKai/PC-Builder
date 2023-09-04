import 'package:custom_pc/domain/url_builder.dart';
import 'package:custom_pc/old/providers/pc_parts_list.dart';
import 'package:custom_pc/old/providers/search_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProviderOld = StateProvider<String>((ref) {
  return '';
});

class PartsListAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PartsListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: ref.watch(searchTextProviderOld));
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
    const mainColor = Color.fromRGBO(60, 130, 80, 1);

    // 検索キーワード入力前に検索のパラメータが選択されている場合の考慮
    void setupSearchParams() {
      final params = ref.read(searchParameterProvider)!;
      final standardPage = ref.read(searchParameterProvider)!.standardPage();
      final url = UrlBuilder.createURLWithParameters(standardPage, params.selectedParameters());
      ref.read(pcPartsListNotifierProvider.notifier).replaceSearchUrl(url);
    }

    return WillPopScope(
      onWillPop: () async {
        ref.read(searchTextProviderOld.notifier).update((state) => '');
        return true;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AppBar(
          backgroundColor: mainColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          title: SizedBox(
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEDECF2),
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Container(
                  width: 340,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: controller,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: mainColor,
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ref.read(searchTextProviderOld.notifier).update((state) => '');
                          setupSearchParams();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: mainColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (text) {
                      final trimText = text.trim();
                      if (trimText == '' || trimText == '　') {
                        return;
                      }

                      ref.read(searchTextProviderOld.notifier).update((state) => text);
                      setupSearchParams();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
