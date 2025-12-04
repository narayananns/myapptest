import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';
import 'common_textfield.dart';

void openStockPopup(BuildContext context, AddProductController ctrl) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Product Item + Size",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            CommonTextField(
              hint: "Enter the number of items",
              controller: ctrl.stockItemCtrl,
            ),
            const SizedBox(height: 10),

            CommonTextField(
              hint: 'Enter "S" or "32"',
              controller: ctrl.stockSizeCtrl,
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ctrl.addStockItem();
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
