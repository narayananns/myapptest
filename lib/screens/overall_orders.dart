import 'package:flutter/material.dart';
import 'order_details_page.dart';

class OverallOrdersPage extends StatefulWidget {
  const OverallOrdersPage({super.key});

  @override
  State<OverallOrdersPage> createState() => _OverallOrdersPageState();
}

class _OverallOrdersPageState extends State<OverallOrdersPage> {
  // Dummy data for testing
  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-2024-001",
      "username": "John Doe",
      "productName": "Men's Cotton T-Shirt",
      "quantity": 2,
      "status": "New Order",
      "time": "2 mins ago",
    },
    {
      "id": "ORD-2024-002",
      "username": "Jane Smith",
      "productName": "Women's Summer Dress",
      "quantity": 1,
      "status": "New Order",
      "time": "15 mins ago",
    },
    {
      "id": "ORD-2024-003",
      "username": "Mike Ross",
      "productName": "Running Shoes",
      "quantity": 1,
      "status": "New Order",
      "time": "1 hour ago",
    },
    {
      "id": "ORD-2024-004",
      "username": "Rachel Green",
      "productName": "Leather Handbag",
      "quantity": 1,
      "status": "New Order",
      "time": "2 hours ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders"), centerTitle: true),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order["status"],
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          order["time"],
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildDetailRow("Order ID", order["id"], theme),
                    const SizedBox(height: 8),
                    _buildDetailRow("Username", order["username"], theme),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      "Product Name",
                      order["productName"],
                      theme,
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow("Quantity", "${order["quantity"]}", theme),
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
