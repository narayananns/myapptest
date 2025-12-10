import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_page/mypayment_controller.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/mypayment_table.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentController()..loadPayments(),
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Payments",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
        body: Consumer<PaymentController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return PaymentTable();
          },
        ),
      ),
    );
  }
}
