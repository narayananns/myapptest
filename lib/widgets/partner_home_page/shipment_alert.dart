import 'package:flutter/material.dart';

class ShipmentAlert extends StatelessWidget {
  final int pendingShipments;

  const ShipmentAlert({super.key, required this.pendingShipments});

  @override
  Widget build(BuildContext context) {
    // Hide widget if no pending shipments
    if (pendingShipments <= 0) return SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.black,
            size: 38,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              'Urgent : $pendingShipments Shipment Pending',
              style: const TextStyle(
                color: Colors.black,
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'Details',
                      style: TextStyle(color: Colors.white, fontSize: 14),
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
