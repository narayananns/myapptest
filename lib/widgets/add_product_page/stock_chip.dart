import 'package:flutter/material.dart';
import '../../models/add_product_model/product_stock_model.dart';

class StockChip extends StatelessWidget {
  final ProductStock stock;
  final VoidCallback onDelete;

  const StockChip({super.key, required this.stock, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      backgroundColor: Colors.transparent,
      side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.15)),
      label: Text(
        "Qty: ${stock.quantity} - Size: ${stock.size}",
        style: const TextStyle(color: Colors.white),
      ),
      deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
      onDeleted: onDelete,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
