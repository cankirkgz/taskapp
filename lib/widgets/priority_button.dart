import 'package:flutter/material.dart';

class PriorityButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool isSelected;

  const PriorityButton({
    super.key,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 3 : 2,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
