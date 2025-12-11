import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Orders Placed Today Card
/// Displays a circular progress indicator showing orders placed today
class OrdersTodayCard extends StatelessWidget {
  final int ordersPlacedToday;
  final int? maxOrders; // Optional max value for percentage calculation

  const OrdersTodayCard({
    super.key,
    required this.ordersPlacedToday,
    this.maxOrders,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate percentage (if maxOrders is provided, otherwise use 100 as default)
    final max = maxOrders ?? 100;
    final percentage = max > 0 ? (ordersPlacedToday / max).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(36, 36, 36, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Orders Placed Today',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle
          Text(
            'Total number of orders placed today',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          // Circular Progress Indicator
          Center(
            child: CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 12.0,
              percent: percentage,
              center: Text(
                '$ordersPlacedToday',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.grey.shade300,
              backgroundColor: Colors.grey.shade800,
              animation: true,
              animationDuration: 1000,
            ),
          ),
        ],
      ),
    );
  }
}

