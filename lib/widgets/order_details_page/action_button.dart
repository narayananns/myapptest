import 'package:flutter/material.dart';
import 'package:thristoparnterapp/screens/order_details_page.dart';
import '../../config/app_color.dart';

class ActionButtons extends StatelessWidget {
  final String? deliveryType; // <-- From parent page
  final VoidCallback? onConfirm;
  final VoidCallback? onDecline;

  const ActionButtons({
    super.key,
    required this.deliveryType,
    this.onConfirm,
    this.onDecline,
  });

  // -----------------------------------------------------
  // Show alert to choose delivery type
  // -----------------------------------------------------
  void _showDeliveryWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Select Delivery Type",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Please select Self Delivery or Partner Delivery before confirming.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // Show confirm/decline popup
  // -----------------------------------------------------
  void _showActionPopup(BuildContext context, String type) {
    bool isConfirm = type == "confirm";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: (isConfirm ? Colors.green : Colors.red)
                  .withOpacity(0.15),
              child: Icon(
                isConfirm ? Icons.check : Icons.close,
                size: 35,
                color: isConfirm ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isConfirm ? "Confirm Order?" : "Decline Order?",
              style: TextStyle(
                color: isConfirm ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          isConfirm
              ? "Are you sure you want to confirm this order?"
              : "Are you sure you want to decline this order?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog first
              if (isConfirm) {
                onConfirm?.call(); // Notify parent
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("The order has been confirmed"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                onDecline?.call();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isConfirm ? Colors.green : Colors.red,
            ),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // MAIN UI
  // -----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// CONFIRM
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (deliveryType == null) {
                _showDeliveryWarning(context); // Block confirm
                return;
              }
              _showActionPopup(context, "confirm");
            },
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text("Confirm", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.confirmGreen,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),

        const SizedBox(width: 18),

        /// DECLINE
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showActionPopup(context, "decline"),
            icon: const Icon(Icons.close, color: Colors.white),
            label: const Text("Decline", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.declineRed,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
