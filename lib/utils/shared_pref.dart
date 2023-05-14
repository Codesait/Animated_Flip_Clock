import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = 'THEME-STATUS';

  Future<void> setDarkTheme({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}
