import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditingCustomIdNotifier extends StateNotifier<String> {
  EditingCustomIdNotifier(super.state);

  void setState(String id) {
    state = id;
  }
}

final editingCustomIdNotifierProvider = StateNotifierProvider<EditingCustomIdNotifier, String>((ref) {
  return EditingCustomIdNotifier('');
});
