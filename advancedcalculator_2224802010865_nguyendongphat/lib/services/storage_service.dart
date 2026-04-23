import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const String _historyKey = 'history';
  static const String _themeKey = 'theme';
  static const String _memoryKey = 'memory'; // Key để lưu bộ nhớ tạm

  // Lưu lịch sử
  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final data = history.map((e) => e.toJson()).toList();
    await prefs.setString(_historyKey, jsonEncode(data));
  }

  // Tải lịch sử
  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_historyKey);
    if (json == null) return [];
    final List<dynamic> data = jsonDecode(json);
    return data.map((e) => CalculationHistory.fromJson(e)).toList();
  }

  // Lưu giá trị bộ nhớ (Memory)
  Future<void> saveMemory(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_memoryKey, value);
  }

  // Tải giá trị bộ nhớ (Memory)
  Future<double> loadMemory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_memoryKey) ?? 0.0;
  }

  // Các hàm theme...
  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
  }

  Future<String?> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }
}