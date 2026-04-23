import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final StorageService _storage = StorageService();

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() { _loadTheme(); }

  void _loadTheme() async {
    final saved = await _storage.loadTheme();
    if (saved != null) {
      _themeMode = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    _storage.saveTheme(mode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light, 
    scaffoldBackgroundColor: AppColors.primaryLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.black, 
      tertiary: AppColors.accentLight,
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark, 
    scaffoldBackgroundColor: AppColors.primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: Colors.white,
      tertiary: AppColors.accentDark,
    ),
  );
}