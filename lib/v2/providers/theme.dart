import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeMode {
  light,
  dark,
  followSystem,
}

final themeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.followSystem;
});
