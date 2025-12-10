import 'dart:async';
import 'package:thristoparnterapp/models/profile_page/mypayments_model.dart';

class PaymentService {
  Future<List<PaymentModel>> fetchPayments(int page, int limit) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    return List.generate(limit, (index) {
      int id = (page - 1) * limit + index + 1;
      return PaymentModel(
        date: "2023-10-${(index % 28) + 1}",
        orderNo: "ORD-${1000 + id}",
        amount: "₹${(index + 1) * 150}",
        status: index % 3 == 0 ? "Pending" : "Paid",
      );
    });
  }
}
