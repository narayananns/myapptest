import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/add_product_controller.dart';

import '../widgets/add_product_page/photos_row.dart';
import '../widgets/add_product_page/selection_title.dart';
import '../widgets/add_product_page/common_textfield.dart';
import '../widgets/add_product_page/gender_button.dart';
import '../widgets/add_product_page/common_dropdown.dart';
import '../widgets/add_product_page/multiline_box.dart';
import '../widgets/add_product_page/stock_chip.dart';
import '../widgets/add_product_page/color_chip.dart';
import '../widgets/add_product_page/stock_popup.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AddProductController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(text: "Product Photos"),
            PhotosRow(ctrl: ctrl),
            const SizedBox(height: 20),

            const SectionTitle(text: "Product Details"),
            CommonTextField(hint: "Product Name", controller: ctrl.nameCtrl),
            const SizedBox(height: 12),
            CommonTextField(hint: "Product ID", controller: ctrl.idCtrl),

            const SizedBox(height: 12),

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
              ],
            ),

            const SizedBox(height: 20),

            DropdownField(
              hint: "Select Category",
              value: ctrl.category,
              items: ctrl.categories,
              onChanged: ctrl.setCategory,
            ),

            const SizedBox(height: 12),

            DropdownField(
              hint: "Select Sub Category",
              value: ctrl.subCategory,
              items: ctrl.category != null
                  ? ctrl.subCategoryMap[ctrl.category] ?? []
                  : [],
              onChanged: ctrl.setSubCategory,
            ),

            const SizedBox(height: 25),

            const SectionTitle(text: "Product Pricing"),
            const SizedBox(height: 12),
            CommonTextField(
              hint: "Price Before Discount",
              controller: ctrl.priceBeforeCtrl,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            CommonTextField(
              hint: "Selling Price",
              controller: ctrl.sellingPriceCtrl,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 25),

            const SectionTitle(text: "Product Specifications"),
            // --- TOTAL QUANTITY + ADD BUTTON ---
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    hint: "Total Quantity",
                    controller: ctrl.quantityCtrl,
                    readOnly: true,
                    onTap: () => openStockPopup(context, ctrl),
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

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: List.generate(
                ctrl.stockList.length,
                (i) => StockChip(
                  stock: ctrl.stockList[i],
                  onDelete: () => ctrl.removeStockItem(i),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ColorRow(ctrl: ctrl),

            const SizedBox(height: 25),

            CommonTextField(
              hint: "Size Guide (optional)",
              controller: ctrl.sizeGuideCtrl,
            ),

            const SizedBox(height: 20),

            const SectionTitle(text: "Description"),
            MultilineBox(
              controller: ctrl.descriptionCtrl,
              hint: "Product Description...",
            ),

            const SizedBox(height: 12),

            const SectionTitle(text: "Product Care"),
            MultilineBox(
              controller: ctrl.productCareCtrl,
              hint: "Care Instructions...",
            ),

            const SizedBox(height: 12),

            const SectionTitle(text: "Product Review"),
            MultilineBox(
              controller: ctrl.productReviewCtrl,
              hint: "Short Review...",
            ),

            const SizedBox(height: 20),

            DropdownField(
              hint: 'Related Product',
              value: ctrl.selectedRelatedProduct,
              items: ctrl.relatedProducts,
              onChanged: ctrl.setRelatedProduct,
            ),
            
            const SizedBox(height: 12),

            SwitchListTile(
              value: ctrl.isVisible,
              title: const Text("Visible to Customers"),
              onChanged: ctrl.toggleVisibility,
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              value: ctrl.isTopSelling,
              title: const Text("Top Selling"),
              onChanged: ctrl.toggleTopSelling,
            ),

            SwitchListTile(
              value: ctrl.isReturnable,
              title: const Text("Returnable"),
              onChanged: ctrl.toggleReturnable,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => print("Submit Product"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Add Product"),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
