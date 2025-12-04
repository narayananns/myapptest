import 'package:flutter/material.dart';
import '../../models/orderdetails.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItemModel item;

  const OrderItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, size) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: onSurface.withOpacity(0.15), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  theme.brightness == Brightness.dark ? 0.2 : 0.05,
                ),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE (Left)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.image,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 16),

              /// DETAILS (Right)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NAME
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    /// SIZE - QTY - COLOR
                    Text(
                      "Size: ${item.size}",
                      style: TextStyle(
                        fontSize: 14,
                        color: onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "Qty: ${item.qty}",
                      style: TextStyle(
                        fontSize: 14,
                        color: onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      "Color: ${item.color}",
                      style: TextStyle(
                        fontSize: 14,
                        color: onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
