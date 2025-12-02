class AnalyticsModel {
  final String storeName;
  final int totalSalesAmount; // e.g., 185000
  final String totalSalesLabel; // e.g., "₹ 1,85,000"
  final String revenueGrowth; // e.g., "3.2k"
  final double conversionRate; // e.g., 2.5
  final int wishlistItems;
  final int storePageVisits;
  final int activeUsers; // NEW: number of active users (in units)
  final List<double> revenueLast30Days;

  AnalyticsModel({
    required this.storeName,
    required this.totalSalesAmount,
    required this.totalSalesLabel,
    required this.revenueGrowth,
    required this.conversionRate,
    required this.wishlistItems,
    required this.storePageVisits,
    required this.activeUsers,
    required this.revenueLast30Days,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      storeName: json['storeName'] ?? 'Store',
      totalSalesAmount: json['totalSalesAmount'] ?? 0,
      totalSalesLabel: json['totalSalesLabel'] ?? '₹ 0',
      revenueGrowth: json['revenueGrowth'] ?? '0',
      conversionRate: (json['conversionRate'] ?? 0).toDouble(),
      wishlistItems: json['wishlistItems'] ?? 0,
      storePageVisits: json['storePageVisits'] ?? 0,
      activeUsers: json['activeUsers'] ?? 0, // parse from JSON
      revenueLast30Days: (json['revenueLast30Days'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'storeName': storeName,
    'totalSalesAmount': totalSalesAmount,
    'totalSalesLabel': totalSalesLabel,
    'revenueGrowth': revenueGrowth,
    'conversionRate': conversionRate,
    'wishlistItems': wishlistItems,
    'storePageVisits': storePageVisits,
    'activeUsers': activeUsers,
    'revenueLast30Days': revenueLast30Days,
  };
}
