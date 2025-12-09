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
          CircularPercentIndicator(
            radius: 30,
            lineWidth: 6,
            percent: percent,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color.fromRGBO(88, 194, 255, 1),
            backgroundColor: Color.fromRGBO(88, 194, 255, 0.47),
            center: Text(
              centerNumber,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18,
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
                fontSize: 16,
              ),
            ),
          ),
                    const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.deepPurple, size: 14),
              const SizedBox(width: 4),
              Flexible(
                child: FittedBox(
                  child: Text(
                    footerSub,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
