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
    final theme = Theme.of(context);
    final isSelected = ctrl.gender == value;

    final Color selectedBg = theme.colorScheme.primary;
    final Color unselectedBg = theme.colorScheme.surface.withOpacity(0.8);

    final Color selectedTextColor = Colors.white;
    final Color unselectedTextColor = theme.colorScheme.onSurface.withOpacity(
      0.6,
    );

    return GestureDetector(
      onTap: () => ctrl.updateGender(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? selectedBg
                : theme.colorScheme.onSurface.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: isSelected ? selectedTextColor : unselectedTextColor,
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
