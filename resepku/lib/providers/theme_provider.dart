// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  // Muat tema dari penyimpanan
  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('theme') ?? 'system';
    if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  // Simpan tema ke penyimpanan
  _saveTheme(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.light) {
      prefs.setString('theme', 'light');
    } else if (mode == ThemeMode.dark) {
      prefs.setString('theme', 'dark');
    } else {
      prefs.setString('theme', 'system');
    }
  }

  // Toggle tema
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }
}