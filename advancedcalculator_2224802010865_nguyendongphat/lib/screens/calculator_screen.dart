import 'package:flutter/material.dart';
import '../widgets/display_area.dart';
import '../widgets/mode_selector.dart';
import '../widgets/button_grid.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.settings), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
        actions: [IconButton(icon: const Icon(Icons.history), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())))],
      ),
      body: const Column(
        children: [
          Expanded(flex: 3, child: DisplayArea()),
          ModeSelector(),
          SizedBox(height: 16),
          Expanded(flex: 7, child: Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: ButtonGrid())),
        ],
      ),
    );
  }
}