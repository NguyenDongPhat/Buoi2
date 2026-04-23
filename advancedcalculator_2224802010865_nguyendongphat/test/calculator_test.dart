import 'package:advancedcalculator_2224802010865_nguyendongphat/utils/expression_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Logic Tests', () {
    test('Basic arithmetic', () {
      expect(ExpressionParser.evaluate('5+3', false), '8');
      expect(ExpressionParser.evaluate('100-4', false), '96');
      expect(ExpressionParser.evaluate('6×7', false), '42');
      expect(ExpressionParser.evaluate('15÷3', false), '5');
    });

    test('Order of operations', () {
      expect(ExpressionParser.evaluate('2+3×4', false), '14');
      expect(ExpressionParser.evaluate('(2+3)×4', false), '20');
    });

    test('Scientific functions', () {
      expect(ExpressionParser.evaluate('sin(30)', false), '0.5');
      expect(ExpressionParser.evaluate('sqrt(16)', false), '4');
    });

    test('Edge cases', () {
      expect(ExpressionParser.evaluate('5÷0', false), 'Error: Division by zero');
      expect(ExpressionParser.evaluate('sqrt(-4)', false), 'Error: Invalid input');
    });
  });
}