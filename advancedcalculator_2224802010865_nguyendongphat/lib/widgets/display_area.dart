import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../utils/constants.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return GestureDetector(
      onHorizontalDragEnd: (details) { 
        if (details.primaryVelocity! != 0) calc.deleteLast(); 
      },
      child: Container(
        // Đã giảm padding từ 24 xuống 16 để tiết kiệm không gian dọc
        padding: const EdgeInsets.all(16), 
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (calc.hasMemory) 
              const Text("M", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            
            // Dùng Flexible và Cuộn để biểu thức không bao giờ bị tràn dọc
            Flexible(
              child: SingleChildScrollView(
                reverse: true, // Cuộn xuống dưới cùng
                child: Text(
                  calc.expression, 
                  style: AppStyles.displayStyle.copyWith(
                    color: textColor?.withOpacity(0.6), 
                    fontSize: 28
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Dùng FittedBox để kết quả tự thu nhỏ cỡ chữ nếu số quá dài hoặc màn hình nhỏ
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                calc.result, 
                style: AppStyles.displayStyle.copyWith(
                  color: textColor, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 56
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}