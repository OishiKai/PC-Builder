import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/database/custom_repository.dart';
import '../../models/custom.dart';
import '../../widgets/sort_icon_button.dart';

part 'stored_customs.g.dart';

@riverpod
class StoredCustomsNotifier extends _$StoredCustomsNotifier {
  @override
  Future<Map<String, Custom>> build() {
    ref.onDispose(() {
      print('disposed');
    });
    return CustomRepository.getAllCustoms();
  }

  void refresh() async {
    ref.read(alignState.notifier).update((state) => SortState.date);
    state = await AsyncValue.guard(() async {
      return CustomRepository.getAllCustoms();
    });
  }

  void addCustom(Custom custom) async {
    await CustomRepository.insertCustom(custom);
    refresh();
  }

  void deleteCustom(String id) async {
    await CustomRepository.deleteCustom(id);
    refresh();
  }

  void updateCustom(Custom custom, String id) async {
    await CustomRepository.updateCustom(id, custom);
    refresh();
  }

  void sortCustomsByPrice() async {
    state.when(
      data: (data) {
        // 価格降順でソート
        final sorted = data.entries.toList()..sort((a, b) => b.value.calculateTotalPrice().compareTo(a.value.calculateTotalPrice()));
        final sortedMap = Map.fromEntries(sorted.reversed);
        state = AsyncValue.data(sortedMap);
      },
      error: (e, t) {},
      loading: () {},
    );
  }

  void sortCustomsByCreateDate() async {
    state = await AsyncValue.guard(() async {
      return CustomRepository.getAllCustoms();
    });
  }
}
