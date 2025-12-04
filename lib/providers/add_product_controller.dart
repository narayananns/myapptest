import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/add_product_model/product_stock_model.dart';
import '../../models/view_all_products_model.dart';

class AddProductController extends ChangeNotifier {
  // ===================================================================
  // PRODUCT PHOTOS
  // ===================================================================
  List<String> productPhotos = [];
  final ImagePicker _picker = ImagePicker();

  void setData(ProductModel product) {
    nameCtrl.text = product.name;
    idCtrl.text = product.id;
    productPhotos = List.from(product.images);
    sellingPriceCtrl.text = product.sellingPrice.toString();
    priceBeforeCtrl.text = product.mrp.toString();
    descriptionCtrl.text = product.description;

    // Best effort mapping for single values to lists
    stockList.clear();
    if (product.stockList.isNotEmpty) {
      stockList.addAll(product.stockList);
    }
    _updateTotalQuantity();

    colors.clear();
    if (product.colors.isNotEmpty) {
      colors.addAll(product.colors);
    }

    notifyListeners();
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        productPhotos.addAll(images.map((e) => e.path));
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

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

    int qty = int.tryParse(stockItemCtrl.text.trim()) ?? 0;

    stockList.add(ProductStock(quantity: qty, size: stockSizeCtrl.text.trim()));

    stockItemCtrl.clear();
    stockSizeCtrl.clear();

    _updateTotalQuantity();
    notifyListeners();
  }

  void removeStockItem(int index) {
    stockList.removeAt(index);
    _updateTotalQuantity();
    notifyListeners();
  }

  void _updateTotalQuantity() {
    int total = stockList.fold(0, (sum, item) => sum + item.quantity);
    quantityCtrl.text = total.toString();
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
  XFile? sizeGuideImage;

  Future<void> pickSizeGuideImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        sizeGuideImage = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking size guide image: $e");
    }
  }

  void removeSizeGuideImage() {
    sizeGuideImage = null;
    notifyListeners();
  }

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
