import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode?>((_) => ThemeProvider());

class ThemeProvider extends StateNotifier<ThemeMode?> {
  ThemeProvider() : super(ThemeMode.system);

  void changeTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  bool isLightTheme() {
    return state == ThemeMode.light;
  }
}
