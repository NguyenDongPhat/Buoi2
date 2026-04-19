// lib/widgets/mode_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/calculator_mode.dart';
import '../providers/calculator_provider.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildModeButton(context, "Basic", CalculatorMode.basic),
        const SizedBox(width: 20),
        _buildModeButton(context, "Scientific", CalculatorMode.scientific),
      ],
    );
  }

  Widget _buildModeButton(BuildContext context, String title, CalculatorMode mode) {
    final provider = Provider.of<CalculatorProvider>(context);
    bool isActive = provider.mode == mode;
    
    return GestureDetector(
      onTap: () => provider.toggleMode(mode),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive 
                  ? Theme.of(context).colorScheme.tertiary 
                  : Colors.grey,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            )
        ],
      ),
    );
  }
}