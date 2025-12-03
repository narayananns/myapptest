// lib/models/add_product_model/product_stock_model.dart
class ProductStock {
  String itemName;
  String size;

  ProductStock({
    required this.itemName,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "item_name": itemName,
      "size": size,
    };
  }
}
