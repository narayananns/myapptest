import 'package:flutter/material.dart';
import '../../config/app_color.dart';

class DeleveryButtons extends StatefulWidget {
  final Function(String?) onDeliverySelected;

  const DeleveryButtons({super.key, required this.onDeliverySelected});

  @override
  State<DeleveryButtons> createState() => _DeleveryButtonsState();
}

class _DeleveryButtonsState extends State<DeleveryButtons> {
  String? selectedDelivery;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final buttonPadding = EdgeInsets.symmetric(
      horizontal: w * 0.05,
      vertical: 12,
    );

    Widget buildButton({
      required String id,
      required IconData icon,
      required String label,
    }) {
      final isSelected = selectedDelivery == id;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 45,
        padding: EdgeInsets.only(right: isSelected ? 10 : 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// MAIN BUTTON
            ElevatedButton.icon(
              onPressed: () {
                setState(() => selectedDelivery = id);
                widget.onDeliverySelected(selectedDelivery);
              },
              icon: Icon(icon, color: Colors.white),
              label: Text(
                label,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: buttonPadding,
                backgroundColor:
                    isSelected ? Colors.green : AppColors.greyText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),

            /// X BUTTON
            if (isSelected)
              Positioned(
                right: -6,
                top: -6,
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedDelivery = null);
                    widget.onDeliverySelected(null);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: const Icon(Icons.close,
                        size: 15, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (selectedDelivery == null || selectedDelivery == "self")
          buildButton(
            id: "self",
            icon: Icons.directions_bike,
            label: "Self Delivery",
          ),

        const SizedBox(width: 18),

        if (selectedDelivery == null || selectedDelivery == "partner")
          buildButton(
            id: "partner",
            icon: Icons.local_shipping,
            label: "Partner Delivery",
          ),
      ],
    );
  }
}
