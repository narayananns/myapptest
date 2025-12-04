import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
    final h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    double cardHeight = h * 0.32; // fixed height responsive
    double radius = w * 0.12;
    double lineWidth = w * 0.02;
    double percent = count > 0 ? (count / (count + 20)) : 0.7;

    return SizedBox(
      height: cardHeight,
      child: Container(
        padding: EdgeInsets.all(w * 0.04),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products Live',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: w * 0.04,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: w * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.02,
                    vertical: w * 0.008,
                  ),
                  margin: EdgeInsets.only(bottom: h * 0.03),
                  decoration: BoxDecoration(
                    color: status.toLowerCase() == 'active'
                        ? Colors.green
                        : colorScheme.error,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: Colors
                          .white, // White text on Green/Red usually works better than black
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: CircularPercentIndicator(
                radius: radius,
                lineWidth: lineWidth,
                percent: percent,
                backgroundColor: colorScheme.onSurface.withOpacity(0.1),
                progressColor: colorScheme.primary,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  status,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: w * 0.04,
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
