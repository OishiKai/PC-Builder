import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/database/custom_repository.dart';
import '../models/custom.dart';

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
}
