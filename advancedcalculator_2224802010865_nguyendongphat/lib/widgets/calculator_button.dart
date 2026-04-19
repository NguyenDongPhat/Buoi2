import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100)); // [cite: 34]
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16), // [cite: 32]
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 24,
                color: widget.textColor ?? Colors.white,
                fontFamily: 'Roboto', // [cite: 30]
              ),
            ),
          ),
        ),
      ),
    );
  }
}