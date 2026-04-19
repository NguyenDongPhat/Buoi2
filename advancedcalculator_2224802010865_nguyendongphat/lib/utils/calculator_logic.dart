// lib/utils/calculator_logic.dart

class CalculatorLogic {
  // Hàm định dạng kết quả (VD: loại bỏ số .0 ở cuối)
  static String formatResult(String result) {
    if (result.endsWith('.0')) {
      return result.substring(0, result.length - 2);
    }
    return result;
  }

  // Logic đổi dấu (+/-)
  static String toggleSign(String currentResult) {
    if (currentResult == '0' || currentResult == 'Error') return currentResult;
    if (currentResult.startsWith('-')) {
      return currentResult.substring(1); // Bỏ dấu trừ
    } else {
      return '-$currentResult'; // Thêm dấu trừ
    }
  }
}