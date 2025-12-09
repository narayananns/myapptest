import 'package:flutter/material.dart';
import '../../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel data;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isNew = data.isNew;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Define colors based on theme
    final Color newBgColor = isDark
        ? const Color(0xFF1E2A38)
        : const Color(0xffE3F2FD);
    final Color readBgColor = theme.cardColor;
    final Color newBorderColor = isDark
        ? Colors.blueAccent
        : const Color(0xff2196F3);
    final Color readBorderColor = isDark
        ? Colors.grey.shade800
        : Colors.grey.shade300;
    final Color titleColor = isDark
        ? Colors.blueAccent
        : const Color(0xff0D47A1);
    final Color textColor = theme.colorScheme.onSurface;
    final Color subTextColor = theme.colorScheme.onSurface.withOpacity(0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNew ? newBgColor : readBgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isNew ? newBorderColor : readBorderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Order",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                if (isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "NEW",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand Logo
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/zoro.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      _buildDetailRow(
                        "Brand Name",
                        "Zoro",
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(height: 4),
                      _buildDetailRow(
                        "Order ID",
                        "#${data.orderId}",
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(height: 4),
                      _buildDetailRow(
                        "Name",
                        data.customerName,
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(height: 4),
                      _buildDetailRow(
                        "Product",
                        data.productName,
                        textColor,
                        subTextColor,
                      ),
                      const SizedBox(height: 4),
                      _buildDetailRow(
                        "Quantity",
                        "${data.quantity}",
                        textColor,
                        subTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Status at bottom right
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(data.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _getStatusColor(data.status)),
                ),
                child: Text(
                  "Order status : ${data.status}",
                  style: TextStyle(
                    color: _getStatusColor(data.status),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    Color textColor,
    Color subTextColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label :",
            style: TextStyle(color: subTextColor, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
