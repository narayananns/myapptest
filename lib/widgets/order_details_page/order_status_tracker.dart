import 'package:flutter/material.dart';

class OrderStatusTracker extends StatelessWidget {
  final int currentStep; // 0 to 3

  const OrderStatusTracker({super.key, this.currentStep = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final steps = [
      "Order\nConfirmed",
      "Ready for\nPickup",
      "Out for\nDelivery",
      "Delivered",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            "Order Status",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(steps.length, (index) {
              bool isCompleted = index <= currentStep;
              bool isLast = index == steps.length - 1;
              bool isFirst = index == 0;

              return Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Left Line
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isFirst
                                ? Colors.transparent
                                : (index <= currentStep
                                      ? theme.colorScheme.primary
                                      : theme.disabledColor.withOpacity(0.3)),
                          ),
                        ),
                        // Circle Indicator
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? theme.colorScheme.primary
                                : theme.disabledColor.withOpacity(0.3),
                            border: Border.all(
                              color: isCompleted
                                  ? theme.colorScheme.primary
                                  : theme.disabledColor,
                              width: 2,
                            ),
                          ),
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        // Right Line
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isLast
                                ? Colors.transparent
                                : (index <= currentStep
                                      ? theme.colorScheme.primary
                                      : theme.disabledColor.withOpacity(0.3)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: isCompleted
                            ? theme.colorScheme.onSurface
                            : theme.disabledColor,
                        fontWeight: isCompleted
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
