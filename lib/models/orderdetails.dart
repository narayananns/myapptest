class OrderItemModel {
  final String name;
  final String size;
  final int qty;
  final String color;
  final String image;
  final String orderId;
  final double price;

  OrderItemModel({
    required this.name,
    required this.size,
    required this.qty,
    required this.color,
    required this.image,
    required this.orderId,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      qty: json['qty'] ?? 0,
      color: json['color'] ?? '',
      image: json['image'] ?? '',
      orderId: json['order_id'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
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
      'price': price,
    };
  }
}
