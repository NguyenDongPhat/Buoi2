// lib/widgets/display_area.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalculatorProvider>(context);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! != 0) {
          calcProvider.deleteLast(); 
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomRight,
        color: Colors.transparent, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                calcProvider.expression,
                style: const TextStyle(fontSize: 32, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                calcProvider.result,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: calcProvider.hasError 
                      ? Colors.red 
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}