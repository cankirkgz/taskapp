import 'package:flutter/material.dart';
import 'package:task_app/theme/app_colors.dart';

class CategoryDropdown extends StatelessWidget {
  final String? selectedCategory;
  final List<String> categories;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onChanged,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'İş':
        return Icons.work;
      case 'Kişisel':
        return Icons.person;
      case 'Sağlık':
        return Icons.favorite;
      case 'Finans':
        return Icons.attach_money;
      case 'Alışveriş':
        return Icons.shopping_cart;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      hint: Row(
        children: [
          const Icon(Icons.category, color: AppColors.hintText),
          const SizedBox(width: 8),
          const Text("Select a category"),
        ],
      ),
      items: categories.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Row(
            children: [
              Icon(
                _getCategoryIcon(category),
                size: 20,
                color: AppColors.icon,
              ),
              const SizedBox(width: 8),
              Text(category, style: TextStyle(color: AppColors.text)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
      ),
    );
  }
}
