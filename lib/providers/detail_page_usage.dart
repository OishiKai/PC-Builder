import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DetailPageUsage {
  create,
  view,
  edit,
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
