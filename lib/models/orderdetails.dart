class OrderItemModel {
  final String name;
  final String size;
  final int qty;
  final String color;
  final String image;
  final String orderId;

  OrderItemModel({
    required this.name,
    required this.size,
    required this.qty,
    required this.color,
    required this.image,
    required this.orderId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      qty: json['qty'] ?? 0,
      color: json['color'] ?? '',
      image: json['image'] ?? '',
      orderId: json['order_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size,
      'qty': qty,
      'color': color,
      'image': image,
      'order_id': orderId,
    };
  }
}
