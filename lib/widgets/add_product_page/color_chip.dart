import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';
import 'common_textfield.dart';

class ColorRow extends StatelessWidget {
  final AddProductController ctrl;
  const ColorRow({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text("Product Colours", style: TextStyle(fontSize: 18)),
        // const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: ctrl.colorCtrl,
                readOnly: false,
                onTap: null,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter Colour",
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: ctrl.addColor, child: const Text("Add")),
          ],
        ),

        const SizedBox(height: 10),

        Wrap(
          spacing: 8,
          children: List.generate(
            ctrl.colors.length,
            (i) => Chip(
              label: Text(ctrl.colors[i]),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => ctrl.removeColor(i),
            ),
          ),
        ),
      ],
    );
  }
}
