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
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            CircularPercentIndicator(
              radius: 36,
              lineWidth: 8,
              percent: percent,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.lightBlueAccent,
              backgroundColor: Colors.white24,
              center: Text(
                centerNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.purpleAccent,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  footerMain,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              footerSub,
              style: const TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
