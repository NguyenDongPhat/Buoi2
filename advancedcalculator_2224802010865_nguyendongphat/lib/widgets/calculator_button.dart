import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  const CalculatorButton({required this.text, required this.onTap, this.color, this.textColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = Theme.of(context).colorScheme.onSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text, 
            style: TextStyle(
              color: textColor ?? defaultTextColor, 
              fontSize: 20, 
              fontWeight: FontWeight.w500
            )
          ),
        ),
      ),
    );
  }
}