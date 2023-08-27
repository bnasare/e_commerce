import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const THEME_TYPE = 'THEMETYPE';

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_TYPE, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_TYPE) ?? false;
  }
}
