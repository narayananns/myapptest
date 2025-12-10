class PaymentModel {
  final String date;
  final String orderNo;
  final String amount;
  final String status;

  PaymentModel({
    required this.date,
    required this.orderNo,
    required this.amount,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      date: json['date'],
      orderNo: json['orderNo'],
      amount: json['amount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "orderNo": orderNo,
      "amount": amount,
      "status": status,
    };
  }
}
