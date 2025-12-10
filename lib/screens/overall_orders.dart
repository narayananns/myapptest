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
      // Update the first order to Declined for demo purposes
      // In a real app, you would pass the order ID and update that specific order
      if (orders.isNotEmpty) {
        orders[0]['status'] = "Declined";
      }

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
      "status": "In Progress",
      "time": "15 mins ago",
      "price": "₹1,499",
      "brandName": "Zara",
    },
    {
      "id": "ORD-2024-003",
      "username": "Mike Ross",
      "productName": "Running Shoes",
      "quantity": 1,
      "status": "In Progress",
      "time": "1 hour ago",
      "price": "₹2,999",
      "brandName": "Adidas",
    },
    {
      "id": "ORD-2024-004",
      "username": "Rachel Green",
      "productName": "Leather Handbag",
      "quantity": 1,
      "status": "In Progress",
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
      "status": "Declined",
      "time": "2 days ago",
      "price": "₹899",
      "brandName": "Bing",
    },
    {
      "id": "ORD-2024-007",
      "username": "Joey Tribbiani",
      "productName": "Pizza Cutter",
      "quantity": 2,
      "status": "Declined",
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
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsPage(),
                  ),
                );
                if (result != null && result is String) {
                  setState(() {
                    orders[index]['status'] = result;
                  });
                }
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order["brandName"]?.toString() ?? "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order["id"]?.toString() ?? "N/A",
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order["username"]?.toString() ?? "N/A",
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order["productName"]?.toString() ?? "N/A",
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order["price"]?.toString() ?? "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                  fontSize: 15,
                                ),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              _getDisplayStatus(order["status"]),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getDisplayStatus(order["status"]),
                            style: TextStyle(
                              color: _getStatusTextColor(
                                _getDisplayStatus(order["status"]),
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
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

  String _getDisplayStatus(String? status) {
    if (status == null) return "Unknown";
    if (status == "Cancelled") return "Declined";
    if (status == "Shipped" ||
        status == "Order Confirmed" ||
        status == "Out for Delivery" ||
        status == "Returned") {
      return "In Progress";
    }
    return status;
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Declined":
        return Colors.red;
      case "In Progress":
        return Colors.yellow;
      case "New Order":
        return Colors.blue;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getStatusTextColor(String? status) {
    if (status == "In Progress") return Colors.black;
    return Colors.white;
  }
}
