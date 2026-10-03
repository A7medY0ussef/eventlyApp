import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.light;

  void changeAppTheme(ThemeMode newTheme){
    if (newTheme == currentTheme) {
      return;
    }  else{
      currentTheme = newTheme;
      notifyListeners();
    }
  }
  bool get isDark => currentTheme == ThemeMode.dark;
  bool get isLight => currentTheme == ThemeMode.light;
}