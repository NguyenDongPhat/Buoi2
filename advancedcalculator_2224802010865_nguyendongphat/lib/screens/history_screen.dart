import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<HistoryProvider>(context).history;
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, i) {
          final item = history[i];
          return ListTile(
            title: Text(item.expression, style: const TextStyle(color: Colors.grey)),
            subtitle: Text(DateFormat('HH:mm - dd/MM').format(item.timestamp)),
            trailing: Text(item.result, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}