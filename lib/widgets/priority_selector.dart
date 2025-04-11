import 'package:flutter/material.dart';
import 'package:task_app/widgets/priority_button.dart';

class PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final ValueChanged<String> onPriorityChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PriorityButton(
              label: "Düşük",
              icon: Icons.arrow_downward,
              backgroundColor: const Color(0xFFECFDF5),
              borderColor: const Color(0xFF10B981),
              textColor: const Color(0xFF059669),
              isSelected: selectedPriority == "Düşük",
              onTap: () {
                onPriorityChanged("Düşük");
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PriorityButton(
              label: "Orta",
              icon: Icons.horizontal_rule,
              backgroundColor: const Color(0xFFF5F3FF),
              borderColor: const Color(0xFF8B5CF6),
              textColor: const Color(0xFF7C3AED),
              isSelected: selectedPriority == "Orta",
              onTap: () {
                onPriorityChanged("Orta");
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: PriorityButton(
              label: "Yüksek",
              icon: Icons.arrow_upward,
              backgroundColor: const Color(0xFFFFF7ED),
              borderColor: const Color(0xFFF97316),
              textColor: const Color(0xFFEA580C),
              isSelected: selectedPriority == "Yüksek",
              onTap: () {
                onPriorityChanged("Yüksek");
              },
            ),
          ),
        ),
      ],
    );
  }
}
