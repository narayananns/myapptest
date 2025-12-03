import 'package:flutter/material.dart';
import '../models/order_success_model.dart';

class OrderSuccessProvider extends ChangeNotifier {
  OrderSuccessModel? successData;
  bool isLoading = false;

  /// Simulate API or Replace With Real API
  Future<void> fetchOrderSuccessData(String orderId) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    /// TODO: Replace this with your backend API
    successData = OrderSuccessModel(
      orderId: orderId,
      customerName: "Pooja Gupta",
      deliveryTime: _getCurrentTime(),
    );

    isLoading = false;
    notifyListeners();
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }
}
