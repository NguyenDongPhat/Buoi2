import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

class ExpressionParser {
  static String evaluate(String expression, bool isRadians) {
    try {
      // Chuẩn hóa chuỗi trước khi tính toán
      String parsedExp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', math.pi.toString())
          .replaceAll('e', math.e.toString());

      Parser p = Parser();
      Expression exp = p.parse(parsedExp);
      ContextModel cm = ContextModel();

      // Lưu ý: math_expressions tính toán bằng radian mặc định. 
      // Nếu là độ (degrees), cần xử lý riêng hoặc dùng hàm chuyển đổi.
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      // Xử lý chia cho 0 [cite: 247]
      if (eval.isInfinite || eval.isNaN) return 'Error';

      // Xóa số 0 thừa ở đuôi (ví dụ 5.0 -> 5)
      String result = eval.toString();
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
      return result;
    } catch (e) {
      return 'Error';
    }
  }
}