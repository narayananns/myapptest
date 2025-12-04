import 'package:flutter/material.dart';
import '../../models/add_product_model/product_stock_model.dart';

class StockChip extends StatelessWidget {
  final ProductStock stock;
  final VoidCallback onDelete;

  const StockChip({super.key, required this.stock, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text("Qty: ${stock.quantity} - Size: ${stock.size}"),
      deleteIcon: const Icon(Icons.close),
      onDeleted: onDelete,
    );
  }
}
