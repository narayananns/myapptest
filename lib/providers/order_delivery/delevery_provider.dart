import 'package:flutter/material.dart';

class DeliveryProvider extends ChangeNotifier {
  String? selectedDelivery; // "self" or "partner"

  void setDelivery(String type) {
    selectedDelivery = type;
    notifyListeners();
  }

  void clearDelivery() {
    selectedDelivery = null;
    notifyListeners();
  }
}
