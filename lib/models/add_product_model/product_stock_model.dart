// lib/models/add_product_model/product_stock_model.dart
class ProductStock {
  int quantity;
  String size;

  ProductStock({required this.quantity, required this.size});

  Map<String, dynamic> toJson() {
    return {"quantity": quantity, "size": size};
  }
}
