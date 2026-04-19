import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import các Providers
import 'providers/calculator_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/history_provider.dart';

// Import màn hình chính
import 'screens/calculator_screen.dart';

void main() async {
  // Bắt buộc phải có dòng này khi dùng SharedPreferences trong hàm main()
  WidgetsFlutterBinding.ensureInitialized(); 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: const AdvancedCalculatorApp(),
    ),
  );
}

class AdvancedCalculatorApp extends StatelessWidget {
  const AdvancedCalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi của ThemeProvider để cập nhật giao diện
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Advanced Calculator',
      debugShowCheckedModeBanner: false,
      
      // Áp dụng Theme theo thiết lập (Sáng/Tối/Hệ thống)
      themeMode: themeProvider.themeMode,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      
      // Màn hình khởi chạy
      home: const CalculatorScreen(),
    );
  }
}