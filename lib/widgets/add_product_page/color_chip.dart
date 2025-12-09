import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';
import 'common_textfield.dart';

class ColorRow extends StatelessWidget {
  final AddProductController ctrl;
  final bool hasError;
  const ColorRow({super.key, required this.ctrl, this.hasError = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final borderColor = theme.colorScheme.onSurface.withOpacity(0.4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                hint: "Enter Colour *",
                controller: ctrl.colorCtrl,
                hasError: hasError,
              ),
            ),

            const SizedBox(width: 10),

            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: ctrl.addColor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Add"),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: hasError
              ? BoxDecoration(
                  border: Border.all(color: theme.colorScheme.error),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: ctrl.colors.isEmpty
              ? Text(
                  "No colors added",
                  style: TextStyle(
                    color: hasError
                        ? theme.colorScheme.error
                        : textColor.withOpacity(0.5),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: List.generate(
                    ctrl.colors.length,
                    (i) => Chip(
                      label: Text(
                        ctrl.colors[i],
                        style: TextStyle(color: textColor),
                      ),
                      backgroundColor: Colors.transparent,
                      deleteIconColor: textColor.withOpacity(0.7),
                      onDeleted: () => ctrl.removeColor(i),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: borderColor, width: 1),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
