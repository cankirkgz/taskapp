import 'package:flutter/material.dart';
import 'package:task_app/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.white,
        hintStyle: TextStyle(color: AppColors.hintText, fontSize: 18.0),
        prefixIcon: icon != null ? Icon(icon) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
      ),
    );
  }
}
