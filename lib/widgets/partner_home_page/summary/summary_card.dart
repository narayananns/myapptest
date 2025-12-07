import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String revenueText;
  final String growthText;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.revenueText,
    required this.growthText,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Fixed height to ensure consistency across devices and prevent it from being too large
    double cardHeight = 200;

    return SizedBox(
      height: cardHeight,
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: w * 0.04,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee_outlined,
                  color: Colors.blue,
                  size: w * 0.07,
                ),
                SizedBox(width: w * 0.02),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: w * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.arrow_upward, color: Colors.blue, size: w * 0.04),
                SizedBox(width: w * 0.015),
                Text(
                  revenueText,
                  style: TextStyle(color: Colors.grey, fontSize: w * 0.035),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "$growthText ",
                  style: TextStyle(color: Colors.blue, fontSize: w * 0.035),
                ),
                Text(
                  " last month",
                  style: TextStyle(color: Colors.grey, fontSize: w * 0.035),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
