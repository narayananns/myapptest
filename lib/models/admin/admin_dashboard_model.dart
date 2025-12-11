// Admin Dashboard Model
// This model represents the data structure for the admin dashboard
// Backend team should return data in this format

class AdminDashboardModel {
  final int storeLive; // Number of stores currently live/active
  final int totalSales; // Total sales amount (in smallest currency unit)
  final int totalOrders; // Total number of orders
  final int ordersPlacedToday; // Orders placed today
  final List<StoreModel> stores; // List of all stores

  AdminDashboardModel({
    required this.storeLive,
    required this.totalSales,
    required this.totalOrders,
    required this.ordersPlacedToday,
    required this.stores,
  });

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) {
    return AdminDashboardModel(
      storeLive: json['storeLive'] ?? 0,
      totalSales: json['totalSales'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      ordersPlacedToday: json['ordersPlacedToday'] ?? 0,
      stores: (json['stores'] as List<dynamic>? ?? [])
          .map((store) => StoreModel.fromJson(store))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'storeLive': storeLive,
        'totalSales': totalSales,
        'totalOrders': totalOrders,
        'ordersPlacedToday': ordersPlacedToday,
        'stores': stores.map((store) => store.toJson()).toList(),
      };

  /// Format total sales for display
  String get totalSalesFormatted {
    if (totalSales == 0) return '0';
    final s = totalSales.toString();
    if (s.length <= 3) return s;
    final last3 = s.substring(s.length - 3);
    String rest = s.substring(0, s.length - 3);
    final buffer = StringBuffer();
    while (rest.length > 2) {
      buffer.write(',${rest.substring(rest.length - 2)}');
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) buffer.write(',${rest}');
    final formatted =
        '${buffer.toString().split(',').reversed.join(',')},$last3';
    return formatted.replaceFirst(',', '');
  }
}

/// Store Model
/// Represents individual store information
class StoreModel {
  final String id;
  final String name;
  final String logoUrl; // URL or asset path for store logo
  final String? description;
  final bool isActive;
  final int totalOrders;
  final int totalSales;

  StoreModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.description,
    required this.isActive,
    this.totalOrders = 0,
    this.totalSales = 0,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? json['logo_url'] ?? '',
      description: json['description'],
      isActive: json['isActive'] ?? json['is_active'] ?? true,
      totalOrders: json['totalOrders'] ?? json['total_orders'] ?? 0,
      totalSales: json['totalSales'] ?? json['total_sales'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logoUrl': logoUrl,
        'description': description,
        'isActive': isActive,
        'totalOrders': totalOrders,
        'totalSales': totalSales,
      };
}

