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
        final w = size.maxWidth;

        return Container(
          padding: EdgeInsets.all(w * 0.05),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(w * 0.08),
            border: Border.all(
              color: onSurface.withOpacity(0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.2 : 0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.05),
                child: Image.asset(
                  item.image,
                  height: w * 0.55,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: w * 0.03),

              /// NAME
              Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.09,
                  color: onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: w * 0.015),

              /// SIZE - QTY - COLOR
              Text("Size: ${item.size}", style: TextStyle(color: onSurface.withOpacity(0.7))),
              Text("Qty: ${item.qty}", style: TextStyle(color: onSurface.withOpacity(0.7))),
              Text("Color: ${item.color}", style: TextStyle(color: onSurface.withOpacity(0.7))),
            ],
          ),
        );
      },
    );
  }
}
