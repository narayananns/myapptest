import 'package:flutter/material.dart';
import '../../models/add_product_model/product_stock_model.dart';

class AddProductController extends ChangeNotifier {
  // ===================================================================
  // PRODUCT PHOTOS
  // ===================================================================
  List<String> productPhotos = [];

  void addPhoto(String path) {
    productPhotos.add(path);
    notifyListeners();
  }

  void removePhoto(int index) {
    productPhotos.removeAt(index);
    notifyListeners();
  }

  // ===================================================================
  // BASIC DETAILS
  // ===================================================================
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();
  String gender = "Men";

  void updateGender(String g) {
    gender = g;
    notifyListeners();
  }

  // ===================================================================
  // CATEGORY
  // ===================================================================
  String? category;
  String? subCategory;

  final List<String> categories = ["Clothing", "Footwear", "Accessories"];

  final Map<String, List<String>> subCategoryMap = {
    "Clothing": ["T-Shirt", "Shirt", "Hoodie", "Jeans"],
    "Footwear": ["Sneakers", "Sandals", "Boots"],
    "Accessories": ["Watch", "Belt", "Sunglasses"],
  };

  void setCategory(String? value) {
    category = value;
    subCategory = null;
    notifyListeners();
  }

  void setSubCategory(String? value) {
    subCategory = value;
    notifyListeners();
  }

  // ===================================================================
  // PRICE
  // ===================================================================
  TextEditingController priceBeforeCtrl = TextEditingController();
  TextEditingController sellingPriceCtrl = TextEditingController();

  // ===================================================================
  // VISIBILITY
  // ===================================================================
  bool isVisible = true;

  void toggleVisibility(bool v) {
    isVisible = v;
    notifyListeners();
  }

  // ===================================================================
  // STOCK HANDLING
  // ===================================================================
  List<ProductStock> stockList = [];

  TextEditingController stockItemCtrl = TextEditingController();
  TextEditingController stockSizeCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();

  void addStockItem() {
    if (stockItemCtrl.text.isEmpty || stockSizeCtrl.text.isEmpty) return;

    stockList.add(
      ProductStock(
        itemName: stockItemCtrl.text.trim(),
        size: stockSizeCtrl.text.trim(),
      ),
    );

    stockItemCtrl.clear();
    stockSizeCtrl.clear();

    quantityCtrl.text = stockList.length.toString();
    notifyListeners();
  }

  void removeStockItem(int index) {
    stockList.removeAt(index);
    quantityCtrl.text = stockList.length.toString();
    notifyListeners();
  }

  // ===================================================================
  // COLORS
  // ===================================================================
  TextEditingController colorCtrl = TextEditingController();
  List<String> colors = [];

  void addColor() {
    if (colorCtrl.text.trim().isEmpty) return;

    colors.add(colorCtrl.text.trim());
    colorCtrl.clear();
    notifyListeners();
  }

  void removeColor(int index) {
    colors.removeAt(index);
    notifyListeners();
  }

  // ===================================================================
  // SIZE GUIDE
  // ===================================================================
  TextEditingController sizeGuideCtrl = TextEditingController();

  // ===================================================================
  // TOP SELLING
  // ===================================================================
  bool isTopSelling = false;

  void toggleTopSelling(bool v) {
    isTopSelling = v;
    notifyListeners();
  }

  // ===================================================================
  // DESCRIPTION
  // ===================================================================
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController productCareCtrl = TextEditingController();
  TextEditingController productReviewCtrl = TextEditingController();

  // ===================================================================
  // RETURNABLE
  // ===================================================================
  bool isReturnable = true;

  void toggleReturnable(bool v) {
    isReturnable = v;
    notifyListeners();
  }

  // ===================================================================
  // RELATED PRODUCTS  ✅ ALREADY EXISTS (Confirmed)
  // ===================================================================
  List<String> relatedProducts = [
    "None",
    "Best Seller",
    "Frequently Bought",
    "Similar Product",
  ];

  String? selectedRelatedProduct;

  void setRelatedProduct(String? value) {
    selectedRelatedProduct = value;
    notifyListeners();
  }
}
