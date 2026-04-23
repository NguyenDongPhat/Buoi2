import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import '../models/calculator_settings.dart';
import '../utils/expression_parser.dart';
import '../services/storage_service.dart';
import '../utils/calculator_logic.dart'; // Đảm bảo import logic

class CalculatorProvider extends ChangeNotifier {
  String _expression = "";
  String _result = "0";
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees;
  double _memory = 0.0;
  bool _hasMemory = false;
  bool _is2nd = false;
  String _progBase = 'DEC';
  
  final _storage = StorageService();

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  bool get hasMemory => _hasMemory;
  bool get is2nd => _is2nd;
  String get progBase => _progBase;

  CalculatorProvider() { _init(); }

  void _init() async { 
    _memory = await _storage.loadMemory(); 
    _hasMemory = _memory != 0; 
    notifyListeners(); 
  }

  void addToExpression(String value) { _expression += value; notifyListeners(); }
  void clear() { _expression = ""; _result = "0"; notifyListeners(); }
  void deleteLast() { if (_expression.isNotEmpty) _expression = _expression.substring(0, _expression.length - 1); notifyListeners(); }
  
  void toggleSign() {
    _expression = CalculatorLogic.toggleSign(_expression, _mode == CalculatorMode.programmer);
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    _storage.saveMemory(0);
    notifyListeners();
  }

  void memoryRecall() {
    String formattedMem = CalculatorLogic.formatResult(_memory.toString());
    _expression += formattedMem;
    notifyListeners();
  }

  void memoryAdd() {
    double currentVal = double.tryParse(_result) ?? 0;
    _memory += currentVal;
    _hasMemory = _memory != 0;
    _storage.saveMemory(_memory);
    notifyListeners();
  }

  void memorySubtract() {
    double currentVal = double.tryParse(_result) ?? 0;
    _memory -= currentVal;
    _hasMemory = _memory != 0;
    _storage.saveMemory(_memory);
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;
    if (_mode == CalculatorMode.programmer) {
      _result = ExpressionParser.evaluateProgrammer(_expression, _progBase);
    } else {
      _result = ExpressionParser.evaluate(_expression, _angleMode == AngleMode.radians);
    }
    notifyListeners();
  }

  void setProgBase(String newBase) {
    if (_mode != CalculatorMode.programmer) return;
    if (_result != '0' && _result != 'Error') {
      try {
        int currentRadix = _progBase == 'HEX' ? 16 : _progBase == 'OCT' ? 8 : _progBase == 'BIN' ? 2 : 10;
        int newRadix = newBase == 'HEX' ? 16 : newBase == 'OCT' ? 8 : newBase == 'BIN' ? 2 : 10;
        String cleanResult = _result.split('.')[0]; 
        int decimalValue = int.parse(cleanResult, radix: currentRadix);
        _result = decimalValue.toRadixString(newRadix).toUpperCase();
      } catch(e) {}
    }
    _progBase = newBase;
    _expression = ""; 
    notifyListeners();
  }

  void toggle2nd() { _is2nd = !_is2nd; notifyListeners(); }
  void toggleAngleMode() { _angleMode = _angleMode == AngleMode.degrees ? AngleMode.radians : AngleMode.degrees; notifyListeners(); }
  void setMode(CalculatorMode mode) { _mode = mode; notifyListeners(); }
}