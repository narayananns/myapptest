import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../providers/add_product_controller.dart';
import '../../providers/view_product_controller.dart';
import '../../providers/profile_provider.dart';
import '../../models/view_all_products_model.dart';
import 'view_all_products_screen.dart';

import '../widgets/add_product_page/photos_row.dart';
import '../widgets/add_product_page/selection_title.dart';
import '../widgets/add_product_page/common_textfield.dart';
import '../widgets/add_product_page/gender_button.dart';
import '../widgets/add_product_page/common_dropdown.dart';
import '../widgets/add_product_page/multiline_box.dart';
import '../widgets/add_product_page/stock_chip.dart';
import '../widgets/add_product_page/color_chip.dart';
import '../widgets/add_product_page/stock_popup.dart';

class EditProductScreen extends StatefulWidget {
  final bool isEdit;
  final ProductModel? existingProduct;

  const EditProductScreen({
    super.key,
    this.isEdit = true, // Default to true for Edit Screen
    this.existingProduct,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // Validation State
  bool _nameError = false;
  bool _idError = false;
  bool _categoryError = false;
  bool _subCategoryError = false;
  // bool _priceBeforeError = false; // Removed
  bool _sellingPriceError = false;
  bool _quantityError = false;
  bool _colorError = false;
  bool _descriptionError = false;

  @override
  void initState() {
    super.initState();
    // Always load data for edit screen
    if (widget.existingProduct != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctrl = Provider.of<AddProductController>(context, listen: false);
        // Populate controller with existingProduct data
        ctrl.setData(widget.existingProduct!);
      });
    }
  }

  bool _validate(AddProductController ctrl) {
    setState(() {
      _nameError = ctrl.nameCtrl.text.trim().isEmpty;
      _idError = ctrl.idCtrl.text.trim().isEmpty;
      _categoryError = ctrl.category == null;
      _subCategoryError = ctrl.subCategory == null;
      // _priceBeforeError is no longer mandatory
      _sellingPriceError = ctrl.sellingPriceCtrl.text.trim().isEmpty;
      _quantityError = ctrl.stockList.isEmpty;
      _colorError = ctrl.colors.isEmpty;
      _descriptionError = ctrl.descriptionCtrl.text.trim().isEmpty;
    });

    return !_nameError &&
        !_idError &&
        !_categoryError &&
        !_subCategoryError &&
        !_sellingPriceError &&
        !_quantityError &&
        !_colorError &&
        !_descriptionError;
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AddProductController>(context);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        scrolledUnderElevation: 0,
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Text(
                partnerProvider.partner.storeName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 6),
              child: Text(
                "Product Photos",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PhotosRow(ctrl: ctrl),
            ),
            const SizedBox(height: 30),

            const SectionTitle(text: "Product Details"),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CommonTextField(
                    hint: "Product Name *",
                    controller: ctrl.nameCtrl,
                    hasError: _nameError,
                  ),
                  const SizedBox(height: 16),
                  CommonTextField(
                    hint: "Product ID *",
                    controller: ctrl.idCtrl,
                    hasError: _idError,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GenderButton(
                          ctrl: ctrl,
                          value: "Men",
                          icon: Icons.male,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GenderButton(
                          ctrl: ctrl,
                          value: "Women",
                          icon: Icons.female,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GenderButton(
                          ctrl: ctrl,
                          value: "Kids",
                          icon: Icons.child_care,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GenderButton(
                          ctrl: ctrl,
                          value: "Unisex",
                          icon: Icons.people,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownField(
                    hint: "Select Category *",
                    value: ctrl.category,
                    items: ctrl.categories,
                    onChanged: ctrl.setCategory,
                    hasError: _categoryError,
                  ),
                  const SizedBox(height: 16),
                  DropdownField(
                    hint: "Select Sub Category *",
                    value: ctrl.subCategory,
                    items: ctrl.category != null
                        ? ctrl.subCategoryMap[ctrl.category] ?? []
                        : [],
                    onChanged: ctrl.setSubCategory,
                    hasError: _subCategoryError,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const SectionTitle(text: "Product Price"),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CommonTextField(
                    hint: "Price Before Discount",
                    controller: ctrl.priceBeforeCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Enter only if it is a discounted product",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CommonTextField(
                    hint: "Selling Price *",
                    controller: ctrl.sellingPriceCtrl,
                    keyboardType: TextInputType.number,
                    hasError: _sellingPriceError,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const SectionTitle(text: "Product Specifications"),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TOTAL QUANTITY + ADD BUTTON ---
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          hint: "Total Quantity *",
                          controller: ctrl.quantityCtrl,
                          readOnly: true,
                          onTap: () => openStockPopup(context, ctrl),
                          hasError: _quantityError,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => openStockPopup(context, ctrl),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: _quantityError
                        ? BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.error,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: ctrl.stockList.isEmpty
                        ? Text(
                            "No stock added",
                            style: TextStyle(
                              color: _quantityError
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            children: List.generate(
                              ctrl.stockList.length,
                              (i) => StockChip(
                                stock: ctrl.stockList[i],
                                onDelete: () => ctrl.removeStockItem(i),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  ColorRow(ctrl: ctrl, hasError: _colorError),
                  const SizedBox(height: 16),

                  const Text(
                    "Size Guide (optional)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: ctrl.pickSizeGuideImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ctrl.sizeGuideImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(ctrl.sizeGuideImage!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.5),
                                ),
                                Text(
                                  "Tap to upload Size Guide",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (ctrl.sizeGuideImage != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: ctrl.removeSizeGuideImage,
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        label: Text(
                          "Remove",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, top: 8, bottom: 6),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  MultilineBox(
                    controller: ctrl.descriptionCtrl,
                    hint: "Product Description... *",
                    hasError: _descriptionError,
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, top: 8, bottom: 6),
                    child: Text(
                      "Product Care",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  MultilineBox(
                    controller: ctrl.productCareCtrl,
                    hint: "Care Instructions...",
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, top: 8, bottom: 6),
                    child: Text(
                      "Product Review",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  MultilineBox(
                    controller: ctrl.productReviewCtrl,
                    hint: "Short Review...",
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, top: 8, bottom: 6),
                    child: Text(
                      "Related Products",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  DropdownField(
                    hint: 'Related Product',
                    value: ctrl.selectedRelatedProduct,
                    items: ctrl.relatedProducts,
                    onChanged: ctrl.setRelatedProduct,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Visible to Customers",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: ctrl.isVisible,
                          activeColor: Colors.white,
                          onChanged: ctrl.toggleVisibility,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Selling",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: ctrl.isTopSelling,
                          activeColor: Colors.white,
                          onChanged: ctrl.toggleTopSelling,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const SectionTitle(text: "Return Policy"),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Returnable",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: ctrl.isReturnable,
                          activeColor: Colors.white,
                          onChanged: ctrl.toggleReturnable,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(133, 210, 255, 1),
                          Color.fromRGBO(38, 176, 255, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        final productCtrl = Provider.of<ProductController>(
                          context,
                          listen: false,
                        );

                        if (!_validate(ctrl)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please fill all mandatory fields marked with *",
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        // Create Product Model
                        final newProduct = ProductModel(
                          id: widget.existingProduct != null
                              ? widget.existingProduct!.id
                              : DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          name: ctrl.nameCtrl.text,
                          images: ctrl.productPhotos.isNotEmpty
                              ? ctrl.productPhotos
                              : ["https://via.placeholder.com/150"],
                          sellingPrice:
                              double.tryParse(ctrl.sellingPriceCtrl.text) ?? 0,
                          mrp: double.tryParse(ctrl.priceBeforeCtrl.text) ?? 0,
                          description: ctrl.descriptionCtrl.text,
                          stockList: List.from(ctrl.stockList),
                          colors: List.from(ctrl.colors),
                          sold: widget.existingProduct != null
                              ? widget.existingProduct!.sold
                              : 0,
                        );

                        // Always update since this is Edit Screen
                        productCtrl.updateProduct(newProduct);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Product Updated Successfully!"),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Update Product",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
