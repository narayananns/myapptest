import 'package:flutter/material.dart';

class GlanceIconCard extends StatelessWidget {
  final String title;
  final String centerNumber;
  final IconData centerIcon;
  final Color centerIconColor;
  final String footerMain;

  const GlanceIconCard({
    super.key,
    required this.title,
    required this.centerNumber,
    required this.centerIcon,
    required this.centerIconColor,
    required this.footerMain,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(36, 36, 36, 1),
        borderRadius: BorderRadius.circular(12),
        border: theme.brightness == Brightness.light
            ? Border.all(color: Colors.black.withOpacity(0.1))
            : null,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              centerNumber,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Icon(centerIcon, color: centerIconColor, size: 28),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              footerMain,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
