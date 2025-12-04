import 'package:flutter/material.dart';

class ShipmentAlert extends StatelessWidget {
  final int pendingShipments;

  const ShipmentAlert({super.key, required this.pendingShipments});

  @override
  Widget build(BuildContext context) {
    // Hide widget if no pending shipments
    if (pendingShipments <= 0) return SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colorScheme.onErrorContainer,
            size: 38,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              'Urgent : $pendingShipments Shipment Pending',
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              // Navigate to page
            },
            child: GestureDetector(
              onTap: () => {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.onErrorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View',
                      style: TextStyle(
                        color: colorScheme.errorContainer,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Details',
                      style: TextStyle(
                        color: colorScheme.errorContainer,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
