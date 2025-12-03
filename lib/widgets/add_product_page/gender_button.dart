import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';

class GenderButton extends StatelessWidget {
  final AddProductController ctrl;
  final String value;
  final IconData icon;

  const GenderButton({
    super.key,
    required this.ctrl,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = ctrl.gender == value;

    return GestureDetector(
      onTap: () => ctrl.updateGender(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 6),
            Text(value, style: TextStyle(color: isSelected ? Colors.white : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
