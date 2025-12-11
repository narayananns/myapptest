import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/screens/edit_product_page.dart';
import '../../models/view_all_products_model.dart';
import '../../providers/view_product_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Watch the controller to get the latest version of the product
    final productController = context.watch<ProductController>();

    // Find the updated product from the list, or fallback to the widget.product if not found
    final product = productController.products.firstWhere(
      (p) => p.id == widget.product.id,
      orElse: () => widget.product,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,

      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// 🔹 IMAGE CAROUSEL
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: CarouselSlider.builder(
              itemCount: product.images.length,
              itemBuilder: (_, index, __) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: _buildImage(product.images[index]),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 1,
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: (index, _) {
                  setState(() => activeIndex = index);
                },
              ),
            ),
          ),

          /// 🔹 CAROUSEL DOT INDICATORS
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              product.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: activeIndex == index ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: activeIndex == index
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// 🔹 MAIN INFO CONTAINER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PRODUCT NAME + PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${product.sellingPrice.toInt()}",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (product.mrp > product.sellingPrice) ...[
                          const SizedBox(width: 8),
                          Text(
                            "₹${product.mrp.toInt()}",
                            style: TextStyle(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.5,
                              ),
                              fontSize: 24,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 🔸 DESCRIPTION
                Text(
                  "DESCRIPTION",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.description.isNotEmpty
                      ? product.description
                      : "No description available",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔸 SIZE
                Text(
                  "SIZE",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: product.stockList.map((s) {
                    return Chip(
                      backgroundColor: theme.colorScheme.onSurface.withOpacity(
                        0.08,
                      ),
                      label: Text(s.size),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// 🔸 COLOR
                Text(
                  "COLOUR",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: product.colors.map((c) {
                    return Chip(
                      backgroundColor: theme.colorScheme.onSurface.withOpacity(
                        0.08,
                      ),
                      label: Text(c),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                /// 🔸 LIKES + WISHLIST
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LIKES",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.likes.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "WISHLIST",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.wishlist.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// 🔸 STOCK + SOLD
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "STOCK AVAILABLE",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.stockList
                          .fold(0, (sum, item) => sum + item.quantity)
                          .toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ITEMS SOLD",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.sold.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// 🔹 Edit Button (Scrollable)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen(existingProduct: product),
                        ),
                      );
                    },
                    child: Text(
                      "Edit Product",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(child: Icon(Icons.broken_image, size: 40)),
    );
  }
}
