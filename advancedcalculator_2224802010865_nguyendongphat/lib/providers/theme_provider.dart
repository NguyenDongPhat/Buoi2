import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final StorageService _storage = StorageService();

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    String mode = await _storage.loadTheme();
    _themeMode = mode == 'light' ? ThemeMode.light : (mode == 'dark' ? ThemeMode.dark : ThemeMode.system);
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    _storage.saveTheme(mode.toString().split('.').last);
    notifyListeners();
  }

  // ThemeData cho giao diện Sáng (Light) [cite: 28]
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Primary
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFF424242), // Secondary
      tertiary: Color(0xFFFF6B6B),  // Accent
    ),
  );

  // ThemeData cho giao diện Tối (Dark) [cite: 29]
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Primary
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xFF2C2C2C), // Secondary
      tertiary: Color(0xFF4ECDC4),  // Accent
    ),
  );
}