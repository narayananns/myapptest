import 'package:flutter/material.dart';
import '../../models/view_all_products_model.dart';
import '../../models/add_product_model/product_stock_model.dart';

class ProductController extends ChangeNotifier {
  List<ProductModel> products = [];

  void loadProducts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  /// 🔹 SAMPLE DATA FOR UI TESTING
  /// Backend team will replace this with API integration.
  void loadSampleProducts() {
    products = [
      ProductModel(
        id: "1",
        name: "OG Culture Slinger",
        images: [
          "https://via.placeholder.com/900x1600.png?text=OG+Slinger",
          "https://via.placeholder.com/900x1600.png?text=OG+Slinger+Side",
          "https://via.placeholder.com/900x1600.png?text=OG+Slinger+Back",
        ],
        sellingPrice: 2895,
        mrp: 4995,
        description: "Premium sling bag for urban style.",
        stockList: [ProductStock(quantity: 15, size: "Freesize")],
        colors: ["Black"],
        sold: 5,
      ),
      ProductModel(
        id: "2",
        name: "Thunder Dad Cap Black",
        images: [
          "https://via.placeholder.com/900x1600.png?text=Thunder+Cap",
          "https://via.placeholder.com/900x1600.png?text=Cap+Side",
        ],
        sellingPrice: 895,
        mrp: 1295,
        description: "Classic black cap with trendy embroidery.",
        stockList: [ProductStock(quantity: 8, size: "Adjustable")],
        colors: ["Black"],
        sold: 12,
      ),
      ProductModel(
        id: "3",
        name: "Classic Bucket Hat Black",
        images: ["https://via.placeholder.com/900x1600.png?text=Bucket+Hat"],
        sellingPrice: 695,
        mrp: 1195,
        description: "Lightweight bucket hat for summer comfort.",
        stockList: [ProductStock(quantity: 20, size: "M/L")],
        colors: ["Black"],
        sold: 7,
      ),
      ProductModel(
        id: "4",
        name: "Carbon Wave Wallet",
        images: ["https://via.placeholder.com/900x1600.png?text=Wallet"],
        sellingPrice: 895,
        mrp: 1495,
        description: "Minimalistic slim wallet with premium finish.",
        stockList: [ProductStock(quantity: 5, size: "Compact")],
        colors: ["Dark Grey"],
        sold: 3,
      ),
    ];

    notifyListeners();
  }

  void addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void updateProduct(ProductModel product) {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
      notifyListeners();
    }
  }
}
