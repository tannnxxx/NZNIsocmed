import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Naka-set sa light mode sa simula
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners(); // Ito ang nag-uupdate sa UI
  }
}