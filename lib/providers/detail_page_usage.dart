import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DetailPageUsage {
  create('create'),
  view('view'),
  edit('edit');

  final String value;
  const DetailPageUsage(this.value);

  static DetailPageUsage? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return DetailPageUsage.values.firstWhere((e) => e.value == value);
  }
}

class DetailPageUsageNotifier extends StateNotifier<DetailPageUsage> {
  DetailPageUsageNotifier(super.state);

  void switchCreate() {
    state = DetailPageUsage.create;
  }

  void switchView() {
    state = DetailPageUsage.view;
  }

  void switchEdit() {
    state = DetailPageUsage.edit;
  }
}

final detailPageUsageNotifierProvider = StateNotifierProvider<DetailPageUsageNotifier, DetailPageUsage>((ref) {
  return DetailPageUsageNotifier(DetailPageUsage.view);
});
