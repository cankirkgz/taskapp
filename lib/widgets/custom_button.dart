import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool showShadow;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWhite = backgroundColor == Colors.white;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: isWhite
                        ? Colors.grey.shade300
                        : backgroundColor.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
