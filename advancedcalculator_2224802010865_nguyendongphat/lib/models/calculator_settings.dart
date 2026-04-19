// lib/models/calculator_settings.dart

enum AngleMode { degrees, radians }

class CalculatorSettings {
  final AngleMode angleMode;
  final int historySize;

  CalculatorSettings({
    this.angleMode = AngleMode.degrees,
    this.historySize = 50,
  });
}