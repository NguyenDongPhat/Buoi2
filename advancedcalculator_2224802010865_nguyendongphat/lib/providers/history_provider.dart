import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  final StorageService _storage = StorageService();

  List<CalculationHistory> get history => _history;

  HistoryProvider() { _loadHistory(); }

  void _loadHistory() async {
    _history = await _storage.loadHistory();
    notifyListeners();
  }

  void addRecord(String expression, String result) {
    _history.insert(0, CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    ));
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