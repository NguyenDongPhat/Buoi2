import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(title: const Text("Dark Mode"), trailing: Switch(value: theme.themeMode == ThemeMode.dark, onChanged: (_) => theme.setTheme(theme.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark))),
          const ListTile(title: Text("Decimal Precision"), trailing: Text("2")),
          const ListTile(title: Text("Angle Mode"), trailing: Text("Degrees")),
        ],
      ),
    );
  }
}