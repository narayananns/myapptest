import 'package:flutter/material.dart';

class AmountSection extends StatelessWidget {
  final String amount;

  const AmountSection({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Total Amount :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              amount,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
