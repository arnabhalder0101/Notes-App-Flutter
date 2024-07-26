import 'package:flutter/material.dart';
import 'package:note_tracker/themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData themeData = lightMode;
  // getter --
  ThemeData get getThemeData => themeData;
  // to get is dark or not --
  bool get isDark => (themeData == darkMode);

  // setter - to set a new theme --
  set setThemeData(ThemeData themeData) {
    this.themeData = themeData;
    notifyListeners();
  }

  // we'll use this toggle to switch theme later on --
  void toggleTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
