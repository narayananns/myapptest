import 'package:flutter/material.dart';
import 'package:thristoparnterapp/models/profile_page/mypayments_model.dart';
import 'package:thristoparnterapp/services/mypayment_api.dart';

class PaymentController extends ChangeNotifier {
  final PaymentService _service = PaymentService();

  List<PaymentModel> payments = [];
  int rowsPerPage = 10;
  int currentPage = 1;
  bool isLoading = false;
  int total = 28; // backend should send total count

  Future<void> loadPayments() async {
    try {
      isLoading = true;
      notifyListeners();

      payments = await _service.fetchPayments(currentPage, rowsPerPage);
    } catch (e) {
      debugPrint("Error loading payments: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    if ((currentPage * rowsPerPage) < total) {
      currentPage++;
      loadPayments();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      loadPayments();
    }
  }

  void updateRowsPerPage(int newRows) {
    rowsPerPage = newRows;
    currentPage = 1; // Reset to first page
    loadPayments();
  }
}
