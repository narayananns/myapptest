import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../config/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String image;

  const ProfileHeader({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: InkWell(
                  onTap: () => {}, // Handle edit action for image
                  child: Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text("Profile", style: AppTextStyles.subtitle),
        Text(name, style: AppTextStyles.title),
      ],
    );
  }
}
