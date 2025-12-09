import 'package:flutter/material.dart';
import '../../config/app_color.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? onTap;
  const BottomButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.local_shipping, color: Colors.white),
        label: const Text(
          "Pickup Ready",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
