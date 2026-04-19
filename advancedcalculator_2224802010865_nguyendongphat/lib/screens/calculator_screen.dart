// lib/screens/calculator_screen.dart
import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

// Import các Widgets đã được tách ra
import '../widgets/display_area.dart';
import '../widgets/mode_selector.dart';
import '../widgets/button_grid.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HistoryScreen())
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const SettingsScreen())
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            children: [
              Expanded(flex: 2, child: DisplayArea()), // Đã gọi Widget tách
              SizedBox(height: 10),
              ModeSelector(),                          // Đã gọi Widget tách
              SizedBox(height: 10),
              Expanded(flex: 5, child: ButtonGrid()),  // Đã gọi Widget tách
            ],
          ),
        ),
      ),
    );
  }
}