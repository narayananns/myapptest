import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Quick ',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: h * 0.065, // responsive height
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 112, 165, 245),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: w * 0.055,  // responsive icon
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          'Add New Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.04, // responsive text
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: w * 0.03),

            Expanded(
              child: SizedBox(
                height: h * 0.065,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout_outlined,
                          color: Colors.black,
                          size: w * 0.055,
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          'Manage All Products',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
