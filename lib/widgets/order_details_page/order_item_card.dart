import 'package:flutter/material.dart';
import '../../models/orderdetails.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Colors from specs
    const Color cardBgColor = Color.fromRGBO(255, 255, 255, 1);
    const Color imageBgColor = Color.fromRGBO(217, 217, 217, 0.29);
    const Color nameColor = Color.fromRGBO(0, 0, 0, 1);
    const Color detailsColor = Color.fromRGBO(111, 111, 111, 1);
    const Color shadowColor = Color.fromRGBO(80, 80, 80, 0.21);

    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: shadowColor, blurRadius: 19.7, offset: Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          // Image
          Positioned(
            left: 12,
            top: 15, // Approximate vertical centering
            child: Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: imageBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(item.image, fit: BoxFit.cover),
              ),
            ),
          ),

          // Text Details
          Positioned(
            left: 84, // 12 (padding) + 60 (image) + 12 (gap)
            top: 12,
            right: 8,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: nameColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Size: ${item.size}",
                  style: const TextStyle(color: detailsColor, fontSize: 10),
                ),
                Text(
                  "Qty: ${item.qty}",
                  style: const TextStyle(color: detailsColor, fontSize: 10),
                ),
                Text(
                  "Color: ${item.color}",
                  style: const TextStyle(color: detailsColor, fontSize: 10),
                ),
                const SizedBox(height: 2),
                Text(
                  "Price: ₹${item.price.toInt()}",
                  style: const TextStyle(
                    color: detailsColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
