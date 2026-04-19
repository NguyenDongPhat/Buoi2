import 'package:flutter/material.dart';
import '../utils/expression_parser.dart';
import '../models/calculator_mode.dart';
import '../models/calculator_settings.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = "";
  String _result = "0";
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees;
  
  double _memory = 0;
  bool _hasMemory = false;
  bool _hasError = false;

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  bool get hasMemory => _hasMemory;
  bool get hasError => _hasError;

  void addToExpression(String value) {
    if (_hasError) clear();
    _expression += value;
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;
    String res = ExpressionParser.evaluate(_expression, _angleMode == AngleMode.radians);
    if (res == 'Error') {
      _hasError = true;
      _result = 'Error';
    } else {
      _result = res;
      _hasError = false;
    }
    notifyListeners();
  }

  void clear() {
    _expression = "";
    _result = "0";
    _hasError = false;
    notifyListeners();
  }

  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void toggleMode(CalculatorMode newMode) {
    _mode = newMode;
    notifyListeners();
  }

  // Memory Functions [cite: 151-171]
  void memoryAdd() {
    if (_result != 'Error') {
      _memory += double.tryParse(_result) ?? 0;
      _hasMemory = true;
      notifyListeners();
    }
  }

  void memorySubtract() {
    if (_result != 'Error') {
      _memory -= double.tryParse(_result) ?? 0;
      _hasMemory = true;
      notifyListeners();
    }
  }

  void memoryRecall() {
    if (_hasMemory) addToExpression(_memory.toString());
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }
}