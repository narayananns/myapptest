import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenueChart extends StatelessWidget {
  final List<double> points;
  const RevenueChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBg = theme.colorScheme.onBackground;
    final primary = theme.colorScheme.primary;

    if (points.isEmpty) {
      return Center(child: Text('No data', style: theme.textTheme.bodyLarge));
    }

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final spots = List.generate(
      points.length,
      (i) => FlSpot(i.toDouble(), points[i]),
    );

    final maxPoint = points.reduce((a, b) => a > b ? a : b);
    final maxY = (maxPoint * 1.2).clamp(10.0, double.infinity);

    return SizedBox(
      height: h * 0.25,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.01),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              horizontalInterval: maxY / 4,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: onBg.withOpacity(0.05), strokeWidth: 1),
            ),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: w * 0.12,
                  getTitlesWidget: (value, _) => Text(
                    value.toStringAsFixed(0),
                    style: TextStyle(
                      color: onBg.withOpacity(0.6),
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) => Text(
                    '${value.toInt() + 1}',
                    style: TextStyle(
                      color: onBg.withOpacity(0.6),
                      fontSize: w * 0.035,
                    ),
                  ),
                ),
              ),
            ),

            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: (points.length - 1).toDouble(),
            minY: 0,
            maxY: maxY,

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: (w * 0.01).clamp(2.0, 5.0),

                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) {
                    return FlDotCirclePainter(
                      radius: 3.5,
                      color: primary,
                      strokeWidth: 1,
                      strokeColor: onBg.withOpacity(0.3),
                    );
                  },
                ),

                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [primary.withOpacity(0.22), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),

                color: primary,
              ),
            ],

            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => theme.cardColor,
                tooltipPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                tooltipBorderRadius: BorderRadius.circular(6),
                getTooltipItems: (spots) => spots
                    .map(
                      (e) => LineTooltipItem(
                        e.y.toStringAsFixed(2),
                        TextStyle(color: onBg, fontWeight: FontWeight.bold),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
