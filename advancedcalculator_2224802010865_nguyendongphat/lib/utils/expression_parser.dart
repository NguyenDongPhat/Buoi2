import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class ExpressionParser {
  static String evaluate(String expression, bool isRadians) {
    try {
      String expStr = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', math.pi.toString())
          .replaceAll('e', math.e.toString());

      expStr = expStr.replaceAll('log(', 'log(10, ');
      
      expStr = expStr.replaceAllMapped(RegExp(r'(\d)([πe\(a-zA-Z])'), (m) => '${m[1]}*${m[2]}');
      expStr = expStr.replaceAllMapped(RegExp(r'([πe\)])(\d|\(|[a-zA-Z])'), (m) => '${m[1]}*${m[2]}');

      int open = RegExp(r'\(').allMatches(expStr).length;
      int close = RegExp(r'\)').allMatches(expStr).length;
      while (open > close) { expStr += ')'; close++; }

      if (!isRadians) {
        expStr = expStr.replaceAllMapped(RegExp(r'(asin|acos|atan|sin|cos|tan)\(([^)]+)\)'), (match) {
          String func = match.group(1)!;
          String inner = match.group(2)!;
          if (func.startsWith('a')) return '($func($inner)*180/${math.pi})';
          return '$func(($inner)*${math.pi}/180)';
        });
      }

      Parser p = Parser();
      Expression exp = p.parse(expStr);
      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (eval.isInfinite || eval.isNaN) return 'Error';
      
      String res = eval.toStringAsFixed(10);
      while (res.contains('.') && (res.endsWith('0') || res.endsWith('.'))) {
        res = res.substring(0, res.length - 1);
      }
      return res;
    } catch (e) { return 'Error'; }
  }

  // Hàm dành riêng cho Programmer Mode [cite: 100-102]
  static String evaluateProgrammer(String expr, String baseStr) {
    try {
      // Xác định hệ cơ số hiện tại
      int radix = baseStr == 'HEX' ? 16 : baseStr == 'OCT' ? 8 : baseStr == 'BIN' ? 2 : 10;

      // Chuẩn hóa chuỗi để dễ cắt (thêm khoảng trắng quanh các toán tử)
      String parsedExp = expr
          .replaceAll('×', ' * ').replaceAll('÷', ' / ')
          .replaceAll('+', ' + ').replaceAll('-', ' - ')
          .replaceAll('AND', ' AND ').replaceAll('OR', ' OR ')
          .replaceAll('XOR', ' XOR ').replaceAll('NOT', ' NOT ')
          .replaceAll('<<', ' << ').replaceAll('>>', ' >> ');

      // Cắt chuỗi thành các phần tử
      List<String> tokens = parsedExp.split(' ').where((e) => e.isNotEmpty).toList();

      int result = 0;
      String currentOp = '+';
      bool isNot = false;

      // Thuật toán tính toán tuần tự từ trái sang phải cho số nguyên
      for (String token in tokens) {
        if (['+', '-', '*', '/', 'AND', 'OR', 'XOR', '<<', '>>'].contains(token)) {
          currentOp = token;
        } else if (token == 'NOT') {
          isNot = true;
        } else {
          // Parse string sang số nguyên theo hệ cơ số tương ứng
          int val = int.parse(token, radix: radix);
          if (isNot) { val = ~val; isNot = false; } // Xử lý phép đảo bit (NOT)

          switch (currentOp) {
            case '+': result += val; break;
            case '-': result -= val; break;
            case '*': result *= val; break;
            case '/': result ~/= val; break;
            case 'AND': result &= val; break;
            case 'OR': result |= val; break;
            case 'XOR': result ^= val; break;
            case '<<': result <<= val; break;
            case '>>': result >>= val; break;
          }
        }
      }

      // Đổi kết quả ngược lại thành chuỗi theo hệ cơ số đang chọn 
      if (radix == 16) return result.toRadixString(16).toUpperCase();
      if (radix == 8) return result.toRadixString(8).toUpperCase();
      if (radix == 2) return result.toRadixString(2).toUpperCase();
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }
}