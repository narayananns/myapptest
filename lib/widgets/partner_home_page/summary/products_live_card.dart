import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;

class ProductsLiveCard extends StatelessWidget {
  final int count;
  final String status;

  const ProductsLiveCard({
    super.key,
    required this.count,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Fixed height to ensure consistency across devices and prevent it from being too large
    double cardHeight = 200;
    double radius = math.min(w * 0.1, 40.0);
    double lineWidth = math.min(w * 0.02, 8.0);
    double percent = count > 0 ? (count / (count + 20)) : 0.7;

    return SizedBox(
      height: cardHeight,
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(36, 36, 36, 1),
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
              'Products Live',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: math.min(w * 0.04, 16.0),
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: math.min(w * 0.08, 32.0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.02),
              ],
            ),
            Center(
              child: CircularPercentIndicator(
                radius: radius,
                lineWidth: lineWidth,
                percent: percent,
                backgroundColor: const Color.fromRGBO(88, 194, 255, 0.47),
                progressColor: const Color.fromRGBO(88, 194, 255, 1),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  status,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: math.min(w * 0.04, 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
