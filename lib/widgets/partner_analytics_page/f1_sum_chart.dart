import 'package:flutter/material.dart';

class f1_sum_card extends StatelessWidget {
  final String title1;
  final String value1;
  final String subtitle1;
  final Widget? trailing1;

  final String title2;
  final String value2;
  final String subtitle2;
  final Widget? trailing2;

  const f1_sum_card({
    super.key,
    required this.title1,
    required this.value1,
    required this.subtitle1,
    this.trailing1,
    required this.title2,
    required this.value2,
    required this.subtitle2,
    this.trailing2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Card(
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: onSurface.withOpacity(0.08), // 🔥 Border visible in light + dark
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT ITEM BLOCK
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                      color: onSurface.withOpacity(0.70),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle1,
                    style: TextStyle(
                      color: onSurface.withOpacity(0.55),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            if (trailing1 != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: trailing1!,
              ),
          ],
        ),
      ),
    );
  }
}
