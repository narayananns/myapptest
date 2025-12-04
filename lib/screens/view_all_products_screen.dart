import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/view_product_controller.dart';
import '../../models/view_all_products_model.dart';
import '../../models/add_product_model/product_stock_model.dart';
import '../widgets/view_all_product/product_card.dart';
import 'product_details_screen.dart';

class ViewAllProductsScreen extends StatefulWidget {
  const ViewAllProductsScreen({super.key});

  @override
  State<ViewAllProductsScreen> createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  int selectedTab = 0; // 0 = Live, 1 = Out of Stock

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final controller = context.read<ProductController>();

      if (controller.products.isEmpty) {
        controller.loadProducts([
          ProductModel(
            id: "1",
            name: "Thunder Cap Black",
            images: [
              "assets/images/zoro.jpg",
              "assets/images/zoro_side.jpg",
              "assets/images/zoro_back.jpg",
            ],
            sellingPrice: 895,
            mrp: 1295,
            description: "Premium black cap with modern street style.",
            stockList: [ProductStock(quantity: 5, size: "Freesize")],
            colors: ["Black"],
            sold: 0,
          ),
          ProductModel(
            id: "2",
            name: "OG Culture Slinger",
            images: ["assets/images/slinger1.jpg"],
            sellingPrice: 2895,
            mrp: 4995,
            description: "Classic sling bag with durability and design.",
            stockList: [ProductStock(quantity: 10, size: "Freesize")],
            colors: ["Black"],
            sold: 2,
          ),
          ProductModel(
            id: "3",
            name: "Classic Bucket Hat",
            images: ["assets/images/bucket1.jpg"],
            sellingPrice: 695,
            mrp: 1195,
            description: "Trendy bucket hat, lightweight and breathable.",
            stockList: [ProductStock(quantity: 7, size: "M/L")],
            colors: ["Black"],
            sold: 1,
          ),
          ProductModel(
            id: "4",
            name: "Carbon Wave Wallet",
            images: ["assets/images/wallet1.jpg"],
            sellingPrice: 895,
            mrp: 1495,
            description: "Minimalistic premium leather wallet.",
            stockList: [ProductStock(quantity: 3, size: "Compact")],
            colors: ["Grey"],
            sold: 0,
          ),
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final inactive = theme.colorScheme.onSurface.withOpacity(0.5);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          /// TABBAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Column(
                      children: [
                        Text(
                          "Live Products",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedTab == 0 ? primary : inactive,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 3,
                          color: selectedTab == 0
                              ? primary
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Column(
                      children: [
                        Text(
                          "Out of Stock",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedTab == 1 ? primary : inactive,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 3,
                          color: selectedTab == 1
                              ? primary
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// GRID VIEW — LIVE PRODUCTS
          Expanded(
            child: selectedTab == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double gridWidth = constraints.maxWidth;
                        double cardWidth = (gridWidth - 12) / 2;
                        double imageHeight = cardWidth * (16 / 9);
                        double textSpace = 70;
                        double finalRatio =
                            cardWidth / (imageHeight + textSpace);

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 10),
                          itemCount: controller.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: finalRatio,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemBuilder: (_, index) {
                            final product = controller.products[index];

                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailsScreen(product: product),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                /// OUT OF STOCK VIEW
                : Center(
                    child: Text(
                      "Out of stock products",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: inactive,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
