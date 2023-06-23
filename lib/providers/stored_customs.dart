import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/database/custom_repository.dart';
import '../models/custom.dart';

part 'stored_customs.g.dart';

@riverpod
class StoredCustomsNotifier extends _$StoredCustomsNotifier {
  @override
  Future<Map<String, Custom>> build() {
    return CustomRepository.getAllCustoms();
  }
}
