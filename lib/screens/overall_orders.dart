import 'package:flutter/material.dart';
import 'order_details_page.dart';

class OverallOrdersPage extends StatefulWidget {
  final bool showUndoSnackbar;

  const OverallOrdersPage({super.key, this.showUndoSnackbar = false});

  @override
  State<OverallOrdersPage> createState() => _OverallOrdersPageState();
}

class _OverallOrdersPageState extends State<OverallOrdersPage> {
  @override
  void initState() {
    super.initState();
    if (widget.showUndoSnackbar) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              "The order has been declined",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 10),
            action: SnackBarAction(
              label: "Undo",
              textColor: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsPage(),
                  ),
                );
              },
            ),
          ),
        );
      });
    }
  }

  // Dummy data for testing
  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "username": "John Doe",
      "productName": "Men's Cotton T-Shirt",
      "quantity": 2,
      "status": "New Order",
      "time": "2 mins ago",
      "price": "₹999",
      "brandName": "Zoro",
    },
    {
      "id": "ORD-2024-002",
      "username": "Jane Smith",
      "productName": "Women's Summer Dress",
      "quantity": 1,
      "status": "Order Confirmed",
      "time": "15 mins ago",
      "price": "₹1,499",
      "brandName": "Zara",
    },
    {
      "id": "ORD-2024-003",
      "username": "Mike Ross",
      "productName": "Running Shoes",
      "quantity": 1,
      "status": "Shipped",
      "time": "1 hour ago",
      "price": "₹2,999",
      "brandName": "Adidas",
    },
    {
      "id": "ORD-2024-004",
      "username": "Rachel Green",
      "productName": "Leather Handbag",
      "quantity": 1,
      "status": "Out for Delivery",
      "time": "2 hours ago",
      "price": "₹3,499",
      "brandName": "Gucci",
    },
    {
      "id": "ORD-2024-005",
      "username": "Monica Geller",
      "productName": "Chef's Apron",
      "quantity": 1,
      "status": "Delivered",
      "time": "1 day ago",
      "price": "₹1,299",
      "brandName": "MasterChef",
    },
    {
      "id": "ORD-2024-006",
      "username": "Chandler Bing",
      "productName": "Funny Vest",
      "quantity": 1,
      "status": "Cancelled",
      "time": "2 days ago",
      "price": "₹899",
      "brandName": "Bing",
    },
    {
      "id": "ORD-2024-007",
      "username": "Joey Tribbiani",
      "productName": "Pizza Cutter",
      "quantity": 2,
      "status": "Returned",
      "time": "3 days ago",
      "price": "₹499",
      "brandName": "Joey's Special",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand Logo (Top Left)
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/zoro.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              _buildDetailRow(
                                "Brand Name",
                                order["brandName"]?.toString() ?? "N/A",
                                theme,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                "Order ID",
                                order["id"]?.toString() ?? "N/A",
                                theme,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                "Username",
                                order["username"]?.toString() ?? "N/A",
                                theme,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                "Product Name",
                                order["productName"]?.toString() ?? "N/A",
                                theme,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                "Quantity",
                                "${order["quantity"] ?? 0}",
                                theme,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                "Price",
                                order["price"]?.toString() ?? "N/A",
                                theme,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order["time"] ?? "",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Order Status : ",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.6,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              order["status"] ?? "Unknown",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label :",
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
