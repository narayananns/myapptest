import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Widget? trailing;
  final Color? valueColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.trailing,
    this.valueColor,
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
            color: const Color.fromRGBO(36, 36, 36, 1),
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: onSurface.withOpacity(0.70),
                          fontSize: w * 0.09,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: w * 0.13,
                          fontWeight: FontWeight.bold,
                          color: valueColor ?? onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: w * 0.08,
                          color: onSurface.withOpacity(0.55),
                        ),
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
