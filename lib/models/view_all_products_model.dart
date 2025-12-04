import 'add_product_model/product_stock_model.dart';

class ProductModel {
  final String id;
  final String name;
  final List<String> images;
  final double sellingPrice;
  final double mrp;
  final String description;
  final List<ProductStock> stockList; // Updated
  final List<String> colors; // Updated
  final int sold;

  ProductModel({
    required this.id,
    required this.name,
    required this.images,
    required this.sellingPrice,
    required this.mrp,
    required this.description,
    required this.stockList,
    required this.colors,
    required this.sold,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Parse stock list
    List<ProductStock> parsedStock = [];
    if (json["stock_list"] != null) {
      parsedStock = (json["stock_list"] as List)
          .map(
            (e) => ProductStock(
              quantity: int.tryParse(e["quantity"].toString()) ?? 0,
              size: e["size"]?.toString() ?? "N/A",
            ),
          )
          .toList();
    } else if (json["stock"] != null || json["size"] != null) {
      // Fallback for legacy data
      parsedStock.add(
        ProductStock(
          quantity: int.tryParse(json["stock"].toString()) ?? 0,
          size: json["size"]?.toString() ?? "N/A",
        ),
      );
    }

    // Parse colors
    List<String> parsedColors = [];
    if (json["colors"] != null) {
      parsedColors = (json["colors"] as List).map((e) => e.toString()).toList();
    } else if (json["color"] != null) {
      parsedColors.add(json["color"].toString());
    }

    return ProductModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      images:
          (json["images"] as List?)?.map((e) => e.toString()).toList() ?? [],
      sellingPrice: double.tryParse(json["selling_price"].toString()) ?? 0,
      mrp: double.tryParse(json["mrp"].toString()) ?? 0,
      description: json["description"] ?? "",
      stockList: parsedStock,
      colors: parsedColors,
      sold: int.tryParse(json["sold"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "images": images,
      "selling_price": sellingPrice,
      "mrp": mrp,
      "description": description,
      "stock_list": stockList.map((e) => e.toJson()).toList(),
      "colors": colors,
      "sold": sold,
    };
  }
}
