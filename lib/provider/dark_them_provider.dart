import 'package:e_commerce/services/dark_theme_preferences.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool darkTheme = false;
  bool get getDarkTheme => darkTheme;

  set setDarkTheme(bool value) {
    darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
