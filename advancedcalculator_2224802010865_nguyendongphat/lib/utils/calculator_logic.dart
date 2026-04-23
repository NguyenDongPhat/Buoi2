
class CalculatorLogic {
  static String toggleSign(String currentExpression, bool isProgrammerMode) {
    if (currentExpression.isEmpty) {
      return "-"; 
    } else {
      if (isProgrammerMode) {
        return "$currentExpression * (-1)";
      } else {
        return "$currentExpression×(-1)";
      }
    }
  }

  static String formatResult(String result) {
    if (result == 'Error') return result;
    
    String formatted = result;
    if (formatted.contains('.')) {
      while (formatted.endsWith('0')) {
        formatted = formatted.substring(0, formatted.length - 1);
      }
      if (formatted.endsWith('.')) {
        formatted = formatted.substring(0, formatted.length - 1);
      }
    }
    return formatted;
  }
}