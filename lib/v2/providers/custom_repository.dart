import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/database/custom_repository.dart';
import '../../models/custom.dart';
import '../../widgets/stored_custom_list/sort_icon_button.dart';

part 'gen/custom_repository.g.dart';

@riverpod
class CustomRepositoryNotifier extends _$CustomRepositoryNotifier {
  @override
  Future<List<Custom>> build() {
    return CustomRepository.getAllCustomsV2();
  }

  void refresh() async {
    ref.read(alignState.notifier).update((state) => SortState.date);
    state = await AsyncValue.guard(() async {
      return CustomRepository.getAllCustomsV2();
    });
  }

  void addCustom(Custom custom) async {
    if (custom.name == null) custom = custom.copyWith(name: 'タイトルなし');
    await CustomRepository.insertCustom(custom);
    refresh();
  }

  void deleteCustom(String id) async {
    await CustomRepository.deleteCustom(id);
    refresh();
  }

  void updateCustom(Custom custom) async {
    // 更新なのでidはnullではない
    await CustomRepository.updateCustom(custom.id!, custom);
    refresh();
  }

  void sortCustomsByPrice() async {
    state.when(
      data: (data) {
        // 価格降順でソート
        data.sort((a, b) => b.calculateTotalPrice().compareTo(a.calculateTotalPrice()));
        state = AsyncValue.data(data);
      },
      error: (e, t) {},
      loading: () {},
    );
  }

  void sortCustomsByCreateDate() async {
    state = await AsyncValue.guard(() async {
      return CustomRepository.getAllCustomsV2();
    });
  }
}
