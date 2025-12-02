import 'package:flutter/material.dart';

class TrafficCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String changeLabel;

  const TrafficCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.changeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(w * 0.05),
            border: Border.all(
              color: onSurface.withOpacity(0.08),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.08,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: onSurface.withOpacity(0.70),
                        fontSize: w * 0.07,
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: w * 0.09,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: w * 0.07,
                        color: onSurface.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
              ),

              if (changeLabel.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03,
                    vertical: h * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(w * 0.04),
                  ),
                  child: FittedBox(
                    child: Text(
                      changeLabel,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
