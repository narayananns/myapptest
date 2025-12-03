import 'package:flutter/material.dart';
import '../../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel data;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isNew = data.isNew;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew ? const Color(0xff0D47A1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff002B5B),
            child: Text(
              data.customerName[0],
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),

          const SizedBox(width: 16),

          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "New Order",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  data.customerName,
                  style: TextStyle(
                    color: isNew ? Colors.white : Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Order  #${data.orderId}",
                  style: TextStyle(
                    color: isNew ? Colors.white70 : Colors.grey,
                  ),
                ),
                Text(
                  "${data.productName}\nQuantity : ${data.quantity}",
                  style: TextStyle(
                    color: isNew ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Status Button
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isNew
                  ? const Color(0xff002B5B)
                  : Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              "Order Status : ${data.status}",
              style: TextStyle(
                color: isNew ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
