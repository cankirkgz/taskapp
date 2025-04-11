import 'package:flutter/material.dart';
import 'package:task_app/theme/app_colors.dart';
import 'package:task_app/widgets/custom_check_icon.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String priority;
  final bool isCompleted;
  final bool isPreview;
  final ValueChanged<bool> onCompletedChanged;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.isCompleted,
    required this.onCompletedChanged,
    this.isPreview = false,
  }) : super(key: key);

  Map<String, dynamic> _getColors(String priority) {
    switch (priority.toLowerCase()) {
      case 'düşük':
        return {
          'background': const Color(0xFFECFDF5),
          'checkbox': const Color(0xFF10B981),
          'gradient': [const Color(0xFF059669), const Color(0xFF059669)],
        };
      case 'orta':
        return {
          'background': const Color(0xFFF5F3FF),
          'checkbox': const Color(0xFF8B5CF6),
          'gradient': [const Color(0xFF7C3AED), const Color(0xFFC026D3)],
        };
      case 'yüksek':
        return {
          'background': const Color(0xFFFFF7ED),
          'checkbox': const Color(0xFFF97316),
          'gradient': [const Color(0xFFEA580C), const Color(0xFFDC2626)],
        };
      default:
        return {
          'background': Colors.white,
          'checkbox': Colors.grey,
          'gradient': [Colors.grey, Colors.grey],
        };
    }
  }

  Widget? _buildCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'iş':
        return const Icon(Icons.work, size: 16, color: Colors.white);
      case 'kişisel':
        return const Icon(Icons.person, size: 16, color: Colors.white);
      case 'sağlık':
        return const Icon(Icons.health_and_safety,
            size: 16, color: Colors.white);
      case 'alışveriş':
        return const Icon(Icons.shopping_cart, size: 16, color: Colors.white);
      case 'finans':
        return const Icon(Icons.attach_money, size: 16, color: Colors.white);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(priority);
    final backgroundColor = colors['background'] as Color;
    final checkboxColor = colors['checkbox'] as Color;
    final List<Color> categoryGradient = colors['gradient'] as List<Color>;

    final baseTextStyle = TextStyle(
      fontSize: 16,
      color: isCompleted ? AppColors.unvalidText : Colors.black,
      decoration:
          isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
    );

    // Kategori metni için özel stil (kategori her zaman normal kalsın)
    const categoryTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPreview)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Önizleme",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? AppColors.unvalidText
                          : Colors.grey[700],
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: baseTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomCheckIcon(
                    isChecked: isCompleted,
                    borderColor: checkboxColor,
                    fillColor: checkboxColor,
                    onTap: () => onCompletedChanged(!isCompleted),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Açıklama metni
              Text(
                description,
                style: baseTextStyle,
              ),
              const SizedBox(height: 25),
              // Kategori: gradient arka plan ve ikon (kategori metni normal, çizili değil)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: categoryGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_buildCategoryIcon(category) != null) ...[
                      _buildCategoryIcon(category)!,
                      const SizedBox(width: 6),
                    ],
                    Text(
                      category,
                      style: categoryTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
