import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../config/app_text_styles.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showDot;
  final Widget? navigateTo; // Widget to navigate on tap

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    this.showDot = false,
    this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth;
        double iconSize = cardWidth * 0.17;
        double titleFont = cardWidth * 0.09;

        iconSize = iconSize.clamp(26, 42);
        titleFont = titleFont.clamp(14, 20);

        return GestureDetector(
          onTap: () {
            if (navigateTo != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => navigateTo!),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showDot
                        ? Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox(width: 10, height: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: theme.iconTheme.color?.withOpacity(0.8),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: iconSize,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: AppTextStyles.cardTitle.copyWith(
                        color: theme.textTheme.bodyMedium!.color,
                        fontSize: titleFont,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
