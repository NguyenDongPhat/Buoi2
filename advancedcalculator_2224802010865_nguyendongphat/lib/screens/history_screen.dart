import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Thư viện định dạng ngày tháng
import '../providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // Hộp thoại xác nhận xóa [cite: 230]
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear History'),
                  content: const Text('Are you sure you want to clear all history?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        historyProvider.clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: historyList.isEmpty
          ? const Center(child: Text('No history yet.', style: TextStyle(fontSize: 18)))
          : ListView.separated(
              itemCount: historyList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = historyList[index];
                final timeFormatted = DateFormat('MMM dd, HH:mm').format(item.timestamp);
                
                return ListTile(
                  title: Text(item.expression, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                  subtitle: Text(timeFormatted, style: const TextStyle(fontSize: 12)),
                  trailing: Text(
                    item.result, 
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary
                    )
                  ),
                );
              },
            ),
    );
  }
}