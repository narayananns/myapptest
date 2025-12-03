import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_success_provider.dart';
import '../widgets/order_success_page/success_card.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;

  const OrderSuccessPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),

      body: Center(
        child: Consumer<OrderSuccessProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const CircularProgressIndicator(color: Colors.greenAccent);
            }

            if (provider.successData == null) {
              /// Fetch data on first load
              Future.microtask(() {
                provider.fetchOrderSuccessData(orderId);
              });

              return const CircularProgressIndicator(color: Colors.greenAccent);
            }

            final data = provider.successData!;

            return SuccessCard(
              orderId: data.orderId,
              customerName: data.customerName,
              deliveryTime: data.deliveryTime,
            );
          },
        ),
      ),
    );
  }
}
