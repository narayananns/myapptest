import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../providers/order_delivery/order_provider.dart';

// Widgets
import '../widgets/order_details_page/common_back_button.dart';
import '../widgets/order_details_page/order_item_card.dart';
import '../widgets/order_details_page/action_button.dart';
import '../widgets/order_details_page/amount_section.dart';
import '../widgets/order_details_page/bottom_button.dart';
import '../widgets/order_details_page/delevery_button.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String? deliveryChoice; // 👉 "self" or "partner"

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = OrderProvider().getOrderItems();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// BACK BUTTON
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: CommonBackButton(),
              ),
              const SizedBox(height: 10),

              /// PAGE TITLE
              Center(
                child: Text(
                  "Order Details",
                  style: AppTextStyles.title.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// ORDER ID
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Id ",
                    style: TextStyle(color: theme.colorScheme.onSurface),
                  ),
                  Text(
                    "#Sp-2024-00123",
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// CONFIRM + DECLINE (Delivery choice passed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ActionButtons(
                  deliveryType: deliveryChoice,
                ),
              ),

              const SizedBox(height: 20),

              /// DELIVERY BUTTONS (Callback fixed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: DeleveryButtons(
                  onDeliverySelected: (value) {
                    setState(() {
                      deliveryChoice = value; // update state
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// ORDER LIST TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Order List",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// ORDER ITEMS GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    return OrderItemCard(item: data[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// TOTAL AMOUNT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: AmountSection(amount: "₹ 2,100"),
              ),

              const SizedBox(height: 10),

              /// BOTTOM BUTTON
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: BottomButton(),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
