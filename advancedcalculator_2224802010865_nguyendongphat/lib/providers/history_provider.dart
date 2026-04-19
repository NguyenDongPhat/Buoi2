import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  final StorageService _storage = StorageService();

  List<CalculationHistory> get history => _history;

  HistoryProvider() {
    _init();
  }

  Future<void> _init() async {
    _history = await _storage.loadHistory();
    notifyListeners();
  }

  void addRecord(String exp, String res) {
    // Thêm vào đầu danh sách
    _history.insert(0, CalculationHistory(
      expression: exp,
      result: res,
      timestamp: DateTime.now(),
    ));
    
    // Giới hạn 50 mục [cite: 206]
    if (_history.length > 50) _history.removeLast();
    
    _storage.saveHistory(_history);
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    _storage.saveHistory(_history);
    notifyListeners();
  }
}