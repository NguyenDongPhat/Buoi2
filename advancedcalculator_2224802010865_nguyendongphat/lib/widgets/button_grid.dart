// lib/widgets/button_grid.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/calculator_mode.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalculatorProvider>(context);
    
    if (calcProvider.mode == CalculatorMode.basic) {
      return _buildBasicGrid(calcProvider, context);
    } else {
      return _buildScientificGrid(calcProvider, context);
    }
  }

  Widget _buildBasicGrid(CalculatorProvider calc, BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.tertiary;
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CalculatorButton(text: 'C', textColor: Colors.red, onTap: calc.clear),
        CalculatorButton(text: '(', onTap: () => calc.addToExpression('(')),
        CalculatorButton(text: ')', onTap: () => calc.addToExpression(')')),
        CalculatorButton(text: '÷', color: accentColor, onTap: () => calc.addToExpression('÷')),
        
        CalculatorButton(text: '7', onTap: () => calc.addToExpression('7')),
        CalculatorButton(text: '8', onTap: () => calc.addToExpression('8')),
        CalculatorButton(text: '9', onTap: () => calc.addToExpression('9')),
        CalculatorButton(text: '×', color: accentColor, onTap: () => calc.addToExpression('×')),
        
        CalculatorButton(text: '4', onTap: () => calc.addToExpression('4')),
        CalculatorButton(text: '5', onTap: () => calc.addToExpression('5')),
        CalculatorButton(text: '6', onTap: () => calc.addToExpression('6')),
        CalculatorButton(text: '-', color: accentColor, onTap: () => calc.addToExpression('-')),
        
        CalculatorButton(text: '1', onTap: () => calc.addToExpression('1')),
        CalculatorButton(text: '2', onTap: () => calc.addToExpression('2')),
        CalculatorButton(text: '3', onTap: () => calc.addToExpression('3')),
        CalculatorButton(text: '+', color: accentColor, onTap: () => calc.addToExpression('+')),
        
        CalculatorButton(text: '0', onTap: () => calc.addToExpression('0')),
        CalculatorButton(text: '.', onTap: () => calc.addToExpression('.')),
        CalculatorButton(text: '⌫', onTap: calc.deleteLast),
        CalculatorButton(text: '=', color: accentColor, onTap: calc.calculate),
      ],
    );
  }

  Widget _buildScientificGrid(CalculatorProvider calc, BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.tertiary;
    final mathColor = Theme.of(context).colorScheme.secondary.withOpacity(0.7);

    return GridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.9,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CalculatorButton(text: '2nd', color: mathColor, onTap: () {}), 
        CalculatorButton(text: 'sin', color: mathColor, onTap: () => calc.addToExpression('sin(')),
        CalculatorButton(text: 'cos', color: mathColor, onTap: () => calc.addToExpression('cos(')),
        CalculatorButton(text: 'tan', color: mathColor, onTap: () => calc.addToExpression('tan(')),
        CalculatorButton(text: 'ln', color: mathColor, onTap: () => calc.addToExpression('ln(')),
        CalculatorButton(text: 'log', color: mathColor, onTap: () => calc.addToExpression('log(')),
        
        CalculatorButton(text: 'x²', color: mathColor, onTap: () => calc.addToExpression('^2')),
        CalculatorButton(text: '√', color: mathColor, onTap: () => calc.addToExpression('sqrt(')),
        CalculatorButton(text: 'xʸ', color: mathColor, onTap: () => calc.addToExpression('^')),
        CalculatorButton(text: '(', color: mathColor, onTap: () => calc.addToExpression('(')),
        CalculatorButton(text: ')', color: mathColor, onTap: () => calc.addToExpression(')')),
        CalculatorButton(text: '÷', color: accentColor, onTap: () => calc.addToExpression('÷')),
        
        CalculatorButton(text: 'MC', color: Colors.orange.shade700, onTap: calc.memoryClear),
        CalculatorButton(text: '7', onTap: () => calc.addToExpression('7')),
        CalculatorButton(text: '8', onTap: () => calc.addToExpression('8')),
        CalculatorButton(text: '9', onTap: () => calc.addToExpression('9')),
        CalculatorButton(text: 'C', textColor: Colors.red, onTap: calc.clear),
        CalculatorButton(text: '×', color: accentColor, onTap: () => calc.addToExpression('×')),
        
        CalculatorButton(text: 'MR', color: Colors.orange.shade700, onTap: calc.memoryRecall),
        CalculatorButton(text: '4', onTap: () => calc.addToExpression('4')),
        CalculatorButton(text: '5', onTap: () => calc.addToExpression('5')),
        CalculatorButton(text: '6', onTap: () => calc.addToExpression('6')),
        CalculatorButton(text: '⌫', textColor: Colors.red, onTap: calc.deleteLast),
        CalculatorButton(text: '-', color: accentColor, onTap: () => calc.addToExpression('-')),
        
        CalculatorButton(text: 'M+', color: Colors.orange.shade700, onTap: calc.memoryAdd),
        CalculatorButton(text: '1', onTap: () => calc.addToExpression('1')),
        CalculatorButton(text: '2', onTap: () => calc.addToExpression('2')),
        CalculatorButton(text: '3', onTap: () => calc.addToExpression('3')),
        CalculatorButton(text: '%', color: mathColor, onTap: () => calc.addToExpression('%')),
        CalculatorButton(text: '+', color: accentColor, onTap: () => calc.addToExpression('+')),
        
        CalculatorButton(text: 'M-', color: Colors.orange.shade700, onTap: calc.memorySubtract),
        CalculatorButton(text: '0', onTap: () => calc.addToExpression('0')),
        CalculatorButton(text: '.', onTap: () => calc.addToExpression('.')),
        CalculatorButton(text: '±', color: mathColor, onTap: () {
          if (calc.result != '0' && calc.result != 'Error') {
             calc.addToExpression('×(-1)');
          }
        }),
        CalculatorButton(text: 'π', color: mathColor, onTap: () => calc.addToExpression('π')),
        CalculatorButton(text: '=', color: accentColor, onTap: calc.calculate),
      ],
    );
  }
}