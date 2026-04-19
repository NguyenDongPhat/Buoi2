import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const String _historyKey = 'calc_history';
  static const String _themeKey = 'theme_pref';

  // Lưu lịch sử (tối đa 50 mục theo đề bài [cite: 206])
  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      history.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(_historyKey, encodedData);
  }

  // Đọc lịch sử
  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyStr = prefs.getString(_historyKey);
    if (historyStr == null) return [];
    
    final List<dynamic> decodedData = jsonDecode(historyStr);
    return decodedData.map((item) => CalculationHistory.fromJson(item)).toList();
  }

  // Lưu tùy chọn giao diện [cite: 207]
  Future<void> saveTheme(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode);
  }

  Future<String> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'system';
  }
}