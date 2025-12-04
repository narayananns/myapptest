class DashboardModel {
  final String storeName;
  final int productsLive;
  final String productsLiveStatus;
  final int orderPlaced;
  final int totalOrders;
  final int storePageVisits;
  final int totalSales; // in smallest currency unit or rupees as integer
  final String growthText;
  final int pendingShipments;

  DashboardModel({
    required this.storeName,
    required this.productsLive,
    required this.productsLiveStatus,
    required this.orderPlaced,
    required this.totalOrders,
    required this.storePageVisits,
    required this.totalSales,
    required this.growthText,
    required this.pendingShipments,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      storeName: json['storeName'] ?? 'Nithin X Mia Clothing',
      productsLive: json['productsLive'] ?? 0,
      productsLiveStatus: json['productsLiveStatus'] ?? 'Active',
      orderPlaced: json['orderPlaced'] ?? 5,
      totalOrders: json['totalOrders'] ?? 0,
      storePageVisits: json['storePageVisits'] ?? 0,
      totalSales: json['totalSales'] ?? 0,
      growthText: json['growthText'] ?? '-',
      pendingShipments: json['pendingShipments'] ?? 2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeName': storeName,
      'productsLive': productsLive,
      'productsLiveStatus': productsLiveStatus,
      'orderPlaced': orderPlaced,
      'totalOrders': totalOrders,
      'storePageVisits': storePageVisits,
      'totalSales': totalSales,
      'growthText': growthText,
      'pendingShipments': pendingShipments,
    };
  }

  // helper formatting
  String get totalSalesFormatted {
    // format to Indian rupee style quickly
    final s = totalSales.toString();
    // simple formatting: insert commas every 2/3 digits from right — for the example it's acceptable.
    // For robust formatting, use intl package (not added here to keep simple).
    if (s.length <= 3) return s;
    // naive formatting: group last 3 then pairs
    final last3 = s.substring(s.length - 3);
    String rest = s.substring(0, s.length - 3);
    final buffer = StringBuffer();
    while (rest.length > 2) {
      buffer.write(',${rest.substring(rest.length - 2)}');
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) buffer.write(',${rest}');
    final formatted =
        buffer.toString().split(',').reversed.join(',') + (',' + last3);
    return formatted.replaceFirst(',', '');
  }
}
