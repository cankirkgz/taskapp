import 'package:flutter/material.dart';

class CustomCheckIcon extends StatelessWidget {
  final bool isChecked;
  final Color borderColor;
  final Color fillColor;
  final VoidCallback onTap;

  const CustomCheckIcon({
    super.key,
    required this.isChecked,
    required this.borderColor,
    required this.fillColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 32, // Önceki 28 yerine biraz arttırıldı
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? fillColor : Colors.transparent,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Icon(
          Icons.check,
          size: 20,
          color: isChecked ? Colors.white : borderColor,
        ),
      ),
    );
  }
}
