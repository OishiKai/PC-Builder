import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../share_preferences_instance.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  final prefs = SharedPreferencesInstance().prefs;
  final loaded = prefs.getString('theme');
  if (loaded == null) {
    return ThemeMode.system;
  }
  switch (loaded) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    case 'followSystem':
      return ThemeMode.system;
    default:
      return ThemeMode.system;
  }
});
