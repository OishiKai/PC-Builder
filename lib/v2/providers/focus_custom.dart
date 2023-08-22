import 'package:custom_pc/models/custom.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_custom.g.dart';

// カスタムの作成、閲覧、編集で利用するprovider
@riverpod
class FocusCustom extends _$FocusCustom {
  @override
  Custom build() {
    return const Custom();
  }

  void setState(Custom custom) {
    state = custom;
  }
}
