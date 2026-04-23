import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _btn(context, "Basic", CalculatorMode.basic, calc),
        const SizedBox(width: 16),
        _btn(context, "Scientific", CalculatorMode.scientific, calc),
        const SizedBox(width: 16),
        _btn(context, "Programmer", CalculatorMode.programmer, calc),
      ],
    );
  }

  Widget _btn(BuildContext context, String label, CalculatorMode mode, CalculatorProvider calc) {
    bool active = calc.mode == mode;
    return GestureDetector(
      onTap: () => calc.setMode(mode),
      child: Text(label, style: TextStyle(color: active ? Theme.of(context).colorScheme.tertiary : Colors.grey, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
    );
  }
}