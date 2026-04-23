enum AngleMode { degrees, radians }

class CalculatorSettings {
  final AngleMode angleMode;
  final int decimalPrecision;
  final int historySize;

  CalculatorSettings({
    this.angleMode = AngleMode.degrees,
    this.decimalPrecision = 2,
    this.historySize = 50,
  });
}