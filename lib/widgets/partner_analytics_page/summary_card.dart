import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Widget? trailing;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, size) {
        final w = size.maxWidth;
        final h = size.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(w * 0.05),
            border: Border.all(
              color: onSurface.withOpacity(0.08), // ⭐ Border added
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
                        fontSize: w * 0.08,
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

              if (trailing != null)
                Padding(
                  padding: EdgeInsets.only(left: w * 0.06),
                  child: trailing!,
                ),
            ],
          ),
        );
      },
    );
  }
}
