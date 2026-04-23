import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart'; // ĐÃ THÊM: Import History
import '../models/calculator_mode.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({Key? key}) : super(key: key);

  void _onEquals(CalculatorProvider calc, BuildContext context) {
    calc.calculate(); // 1. Tính ra kết quả
    if (calc.result != 'Error' && calc.expression.isNotEmpty) {
      Provider.of<HistoryProvider>(context, listen: false)
          .addRecord(calc.expression, calc.result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    if (calc.mode == CalculatorMode.basic) return _basic(calc, context);
    if (calc.mode == CalculatorMode.scientific) return _scientific(calc, context);
    return _programmer(calc, context); 
  }

  Widget _basic(CalculatorProvider calc, BuildContext context) {
    final accent = Theme.of(context).colorScheme.tertiary;
    return GridView.count(
      crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12, physics: const NeverScrollableScrollPhysics(),
      children: [
        CalculatorButton(text: "C", textColor: Colors.red, onTap: calc.clear),
        CalculatorButton(text: "CE", textColor: Colors.red, onTap: calc.deleteLast),
        CalculatorButton(text: "%", onTap: () => calc.addToExpression("%")),
        CalculatorButton(text: "÷", color: accent, onTap: () => calc.addToExpression("÷")),
        CalculatorButton(text: "7", onTap: () => calc.addToExpression("7")),
        CalculatorButton(text: "8", onTap: () => calc.addToExpression("8")),
        CalculatorButton(text: "9", onTap: () => calc.addToExpression("9")),
        CalculatorButton(text: "×", color: accent, onTap: () => calc.addToExpression("×")),
        CalculatorButton(text: "4", onTap: () => calc.addToExpression("4")),
        CalculatorButton(text: "5", onTap: () => calc.addToExpression("5")),
        CalculatorButton(text: "6", onTap: () => calc.addToExpression("6")),
        CalculatorButton(text: "-", color: accent, onTap: () => calc.addToExpression("-")),
        CalculatorButton(text: "1", onTap: () => calc.addToExpression("1")),
        CalculatorButton(text: "2", onTap: () => calc.addToExpression("2")),
        CalculatorButton(text: "3", onTap: () => calc.addToExpression("3")),
        CalculatorButton(text: "+", color: accent, onTap: () => calc.addToExpression("+")),
        CalculatorButton(text: "±", onTap: () {
          calc.toggleSign();
        }),
        CalculatorButton(text: "0", onTap: () => calc.addToExpression("0")),
        CalculatorButton(text: ".", onTap: () => calc.addToExpression(".")),
        CalculatorButton(text: "=", color: accent, onTap: () => _onEquals(calc, context)), 
      ],
    );
  }

  Widget _scientific(CalculatorProvider calc, BuildContext context) {
    final accent = Theme.of(context).colorScheme.tertiary;
    final math = Theme.of(context).colorScheme.secondary.withOpacity(0.7);
    return GridView.count(
      crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.8, physics: const NeverScrollableScrollPhysics(),
      children: [
        CalculatorButton(text: "2nd", color: calc.is2nd ? Colors.orange : math, onTap: calc.toggle2nd),
        CalculatorButton(text: calc.is2nd ? "asin" : "sin", color: math, onTap: () => calc.addToExpression(calc.is2nd ? "asin(" : "sin(")),
        CalculatorButton(text: calc.is2nd ? "acos" : "cos", color: math, onTap: () => calc.addToExpression(calc.is2nd ? "acos(" : "cos(")),
        CalculatorButton(text: calc.is2nd ? "atan" : "tan", color: math, onTap: () => calc.addToExpression(calc.is2nd ? "atan(" : "tan(")),
        CalculatorButton(text: "Ln", color: math, onTap: () => calc.addToExpression("ln(")),
        CalculatorButton(text: "log", color: math, onTap: () => calc.addToExpression("log(")),
        CalculatorButton(text: "x²", color: math, onTap: () => calc.addToExpression("^2")),
        CalculatorButton(text: "√", color: math, onTap: () => calc.addToExpression("sqrt(")),
        CalculatorButton(text: "xʸ", color: math, onTap: () => calc.addToExpression("^")),
        CalculatorButton(text: "(", color: math, onTap: () => calc.addToExpression("(")),
        CalculatorButton(text: ")", color: math, onTap: () => calc.addToExpression(")")),
        CalculatorButton(text: "÷", color: accent, onTap: () => calc.addToExpression("÷")),
        CalculatorButton(text: "MC", color: Colors.blueGrey, onTap: calc.memoryClear),
        CalculatorButton(text: "7", onTap: () => calc.addToExpression("7")),
        CalculatorButton(text: "8", onTap: () => calc.addToExpression("8")),
        CalculatorButton(text: "9", onTap: () => calc.addToExpression("9")),
        CalculatorButton(text: "C", textColor: Colors.red, onTap: calc.clear),
        CalculatorButton(text: "×", color: accent, onTap: () => calc.addToExpression("×")),
        CalculatorButton(text: "MR", color: Colors.blueGrey, onTap: calc.memoryRecall),
        CalculatorButton(text: "4", onTap: () => calc.addToExpression("4")),
        CalculatorButton(text: "5", onTap: () => calc.addToExpression("5")),
        CalculatorButton(text: "6", onTap: () => calc.addToExpression("6")),
        CalculatorButton(text: "CE", textColor: Colors.red, onTap: calc.deleteLast),
        CalculatorButton(text: "-", color: accent, onTap: () => calc.addToExpression("-")),
        CalculatorButton(text: "M+", color: Colors.blueGrey, onTap: calc.memoryAdd),
        CalculatorButton(text: "1", onTap: () => calc.addToExpression("1")),
        CalculatorButton(text: "2", onTap: () => calc.addToExpression("2")),
        CalculatorButton(text: "3", onTap: () => calc.addToExpression("3")),
        CalculatorButton(text: "%", color: math, onTap: () => calc.addToExpression("%")),
        CalculatorButton(text: "+", color: accent, onTap: () => calc.addToExpression("+")),
        CalculatorButton(text: "M-", color: Colors.blueGrey, onTap: calc.memorySubtract),
        CalculatorButton(text: "±", onTap: calc.toggleSign),
        CalculatorButton(text: "0", onTap: () => calc.addToExpression("0")),
        CalculatorButton(text: ".", onTap: () => calc.addToExpression(".")),
        CalculatorButton(text: "π", color: math, onTap: () => calc.addToExpression("π")),
        CalculatorButton(text: "=", color: accent, onTap: () => _onEquals(calc, context)),
      ],
    );
  }

  Widget _programmer(CalculatorProvider calc, BuildContext context) {
    final accent = Theme.of(context).colorScheme.tertiary;
    final math = Theme.of(context).colorScheme.secondary.withOpacity(0.7);
    final baseColor = Colors.orange.shade700;

    bool isEnabled(String btn) {
      if (calc.progBase == 'BIN' && !['0','1'].contains(btn)) return false;
      if (calc.progBase == 'OCT' && !['0','1','2','3','4','5','6','7'].contains(btn)) return false;
      if (calc.progBase == 'DEC' && ['A','B','C','D','E','F'].contains(btn)) return false;
      return true;
    }

    Widget numBtn(String text) {
      bool active = isEnabled(text);
      return CalculatorButton(
        text: text, 
        color: active ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        textColor: active ? Theme.of(context).colorScheme.onSecondary : Colors.grey.withOpacity(0.3),
        onTap: active ? () => calc.addToExpression(text) : () {},
      );
    }

    Widget baseBtn(String text) {
      bool active = calc.progBase == text;
      return CalculatorButton(
        text: text, 
        color: active ? baseColor : math,
        onTap: () => calc.setProgBase(text),
      );
    }

    return GridView.count(
      crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 0.8, physics: const NeverScrollableScrollPhysics(),
      children: [
        CalculatorButton(text: "AND", color: math, onTap: () => calc.addToExpression(" AND ")),
        CalculatorButton(text: "OR", color: math, onTap: () => calc.addToExpression(" OR ")),
        CalculatorButton(text: "XOR", color: math, onTap: () => calc.addToExpression(" XOR ")),
        CalculatorButton(text: "NOT", color: math, onTap: () => calc.addToExpression(" NOT ")),
        CalculatorButton(text: "<<", color: math, onTap: () => calc.addToExpression(" << ")),
        CalculatorButton(text: ">>", color: math, onTap: () => calc.addToExpression(" >> ")),
        baseBtn("HEX"), baseBtn("DEC"), baseBtn("OCT"), baseBtn("BIN"),
        CalculatorButton(text: "C", textColor: Colors.red, onTap: calc.clear),
        CalculatorButton(text: "CE", textColor: Colors.red, onTap: calc.deleteLast),
        numBtn("A"), numBtn("B"), numBtn("7"), numBtn("8"), numBtn("9"),
        CalculatorButton(text: "÷", color: accent, onTap: () => calc.addToExpression(" / ")),
        numBtn("C"), numBtn("D"), numBtn("4"), numBtn("5"), numBtn("6"),
        CalculatorButton(text: "×", color: accent, onTap: () => calc.addToExpression(" * ")),
        numBtn("E"), numBtn("F"), numBtn("1"), numBtn("2"), numBtn("3"),
        CalculatorButton(text: "-", color: accent, onTap: () => calc.addToExpression(" - ")),
        CalculatorButton(text: "(", color: math, onTap: () => calc.addToExpression("(")),
        CalculatorButton(text: ")", color: math, onTap: () => calc.addToExpression(")")),numBtn("0"),
        CalculatorButton(text: "±", onTap: calc.toggleSign),
        CalculatorButton(text: "=", color: accent, onTap: () => _onEquals(calc, context)),
        CalculatorButton(text: "+", color: accent, onTap: () => calc.addToExpression(" + ")),
      ],
    );
  }
}