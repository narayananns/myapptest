import 'package:flutter/material.dart';

class GlancePercentCard extends StatelessWidget {
  final String title;
  final String centerNumber;
  final String percentText;
  final Color percentColor;
  final String footerMain;

  const GlancePercentCard({
    super.key,
    required this.title,
    required this.centerNumber,
    required this.percentText,
    required this.percentColor,
    required this.footerMain,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
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
          FittedBox(
            child: Text(
              percentText,
              style: TextStyle(
                color: percentColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
