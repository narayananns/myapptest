class NotificationModel {
  final String id;
  final String customerName;
  final String orderId;
  final String productName;
  final int quantity;

  /// UI + logic related
  final bool isNew;                 // unread / read
  final String status;              // pending, accepted, rejected
  final String type;                // order, system, message (optional)

  /// Time details
  final DateTime timestamp;         // when notification created

  /// Local behavior overrides
  final bool playSound;
  final bool vibrate;

  NotificationModel({
    required this.id,
    required this.customerName,
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.isNew,
    required this.status,
    required this.type,
    required this.timestamp,
    this.playSound = true,
    this.vibrate = true,
  });

  /// Convert JSON → Model (Backend → App)
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"]?.toString() ?? "",
      customerName: json["customer_name"] ?? "",
      orderId: json["order_id"]?.toString() ?? "",
      productName: json["product_name"] ?? "",
      quantity: json["quantity"] is int
          ? json["quantity"]
          : int.tryParse(json["quantity"].toString()) ?? 0,
      isNew: json["is_new"] ?? true,
      status: json["status"] ?? "pending",
      type: json["type"] ?? "order",
      timestamp: json["timestamp"] != null
          ? DateTime.tryParse(json["timestamp"]) ?? DateTime.now()
          : DateTime.now(),
      playSound: json["play_sound"] ?? true,
      vibrate: json["vibrate"] ?? true,
    );
  }

  /// Convert Model → JSON (App → Backend)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "customer_name": customerName,
      "order_id": orderId,
      "product_name": productName,
      "quantity": quantity,
      "is_new": isNew,
      "status": status,
      "type": type,
      "timestamp": timestamp.toIso8601String(),
      "play_sound": playSound,
      "vibrate": vibrate,
    };
  }

  /// Update values (very useful for controller)
  NotificationModel copyWith({
    String? id,
    String? customerName,
    String? orderId,
    String? productName,
    int? quantity,
    bool? isNew,
    String? status,
    String? type,
    DateTime? timestamp,
    bool? playSound,
    bool? vibrate,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      isNew: isNew ?? this.isNew,
      status: status ?? this.status,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      playSound: playSound ?? this.playSound,
      vibrate: vibrate ?? this.vibrate,
    );
  }
}
