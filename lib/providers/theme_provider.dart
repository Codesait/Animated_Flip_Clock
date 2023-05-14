import 'package:flip_clock/utils/shared_pref.dart';
import 'package:flutter/material.dart';


class AppThemeNotifier with ChangeNotifier {

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value:value);
    notifyListeners();
  }
}
