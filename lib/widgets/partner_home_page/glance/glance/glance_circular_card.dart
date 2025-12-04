import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GlanceCircularCard extends StatelessWidget {
  final String title;
  final String centerNumber;
  final double percent;
  final String footerMain;
  final String footerSub;

  const GlanceCircularCard({
    super.key,
    required this.title,
    required this.centerNumber,
    required this.percent,
    required this.footerMain,
    required this.footerSub,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
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
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            CircularPercentIndicator(
              radius: 36,
              lineWidth: 8,
              percent: percent,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: colorScheme.primary,
              backgroundColor: colorScheme.onSurface.withOpacity(0.1),
              center: Text(
                centerNumber,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: colorScheme.tertiary, size: 16),
                const SizedBox(width: 6),
                Text(
                  footerMain,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              footerSub,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
