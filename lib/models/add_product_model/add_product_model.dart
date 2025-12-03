// lib/models/product_model.dart

class ProductStock {
  final String itemName;
  final String size;

  ProductStock({
    required this.itemName,
    required this.size,
  });

  factory ProductStock.fromJson(Map<String, dynamic> json) {
    return ProductStock(
      itemName: json['item_name']?.toString() ?? '',
      size: json['size']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "item_name": itemName,
      "size": size,
    };
  }
}

class ProductModel {
  final String name;
  final String id;
  final String gender;
  final String? category;
  final String? subCategory;

  final double priceBeforeDiscount;
  final double sellingPrice;

  final bool isVisible;

  final List<ProductStock> stockList;

  final String color;
  final String? sizeGuide;

  final bool isTopSelling;

  final String description;
  final String productCare;
  final String productReview;

  final bool isReturnable;

  final String? relatedProduct;

  final List<String> photos;

  ProductModel({
    required this.name,
    required this.id,
    required this.gender,
    this.category,
    this.subCategory,
    required this.priceBeforeDiscount,
    required this.sellingPrice,
    required this.isVisible,
    required this.stockList,
    required this.color,
    this.sizeGuide,
    required this.isTopSelling,
    required this.description,
    required this.productCare,
    required this.productReview,
    required this.isReturnable,
    this.relatedProduct,
    required this.photos,
  });

  /// safe toJson — stockList is non-null and each element has toJson()
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "product_id": id,
      "gender": gender,
      "category": category,
      "sub_category": subCategory,
      "price_before_discount": priceBeforeDiscount,
      "selling_price": sellingPrice,
      "is_visible": isVisible,
      // convert stockList to list of maps
      "stock_list": stockList.map((e) => e.toJson()).toList(),
      "color": color,
      "size_guide": sizeGuide,
      "top_selling": isTopSelling,
      "description": description,
      "product_care": productCare,
      "product_review": productReview,
      "is_returnable": isReturnable,
      "related_product": relatedProduct,
      "photos": photos,
    };
  }

  /// optional: factory so backend -> model easy
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final stockJson = json['stock_list'];
    List<ProductStock> stocks = [];
    if (stockJson is List) {
      stocks = stockJson.map((e) {
        if (e is Map<String, dynamic>) return ProductStock.fromJson(e);
        if (e is Map) return ProductStock.fromJson(Map<String, dynamic>.from(e));
        return ProductStock(itemName: e.toString(), size: '');
      }).toList();
    }

    return ProductModel(
      name: json['name']?.toString() ?? '',
      id: json['product_id']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      category: json['category']?.toString(),
      subCategory: json['sub_category']?.toString(),
      priceBeforeDiscount: (json['price_before_discount'] is num)
          ? (json['price_before_discount'] as num).toDouble()
          : double.tryParse(json['price_before_discount']?.toString() ?? '') ?? 0.0,
      sellingPrice: (json['selling_price'] is num)
          ? (json['selling_price'] as num).toDouble()
          : double.tryParse(json['selling_price']?.toString() ?? '') ?? 0.0,
      isVisible: json['is_visible'] == null ? true : (json['is_visible'] == true),
      stockList: stocks,
      color: json['color']?.toString() ?? '',
      sizeGuide: json['size_guide']?.toString(),
      isTopSelling: json['top_selling'] == true,
      description: json['description']?.toString() ?? '',
      productCare: json['product_care']?.toString() ?? '',
      productReview: json['product_review']?.toString() ?? '',
      isReturnable: json['is_returnable'] == null ? true : (json['is_returnable'] == true),
      relatedProduct: json['related_product']?.toString(),
      photos: (json['photos'] is List) ? List<String>.from(json['photos'].map((e) => e.toString())) : [],
    );
  }
}
