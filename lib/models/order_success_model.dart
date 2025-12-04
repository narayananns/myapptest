class OrderSuccessModel {
  final String orderId;
  final String customerName;
  final String deliveryTime;

  OrderSuccessModel({
    required this.orderId,
    required this.customerName,
    required this.deliveryTime,
  });

  /// JSON Parsing
  factory OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    return OrderSuccessModel(
      orderId: json["orderId"] ?? "",
      customerName: json["customerName"] ?? "",
      deliveryTime: json["deliveryTime"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "customerName": customerName,
      "deliveryTime": deliveryTime,
    };
  }
}
