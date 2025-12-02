import 'package:flutter/material.dart';

class GlanceIconCard extends StatelessWidget {
  final String title;
  final String centerNumber;
  final IconData centerIcon;
  final Color centerIconColor;
  final String footerMain;

  const GlanceIconCard({
    super.key,
    required this.title,
    required this.centerNumber,
    required this.centerIcon,
    required this.centerIconColor,
    required this.footerMain,
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
            Text(title, style: const TextStyle(color: Colors.white70 , fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              centerNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Icon(centerIcon, color: centerIconColor, size: 28),
            const SizedBox(height: 8),
            Text(footerMain, style: const TextStyle(color: Colors.white54 , fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
