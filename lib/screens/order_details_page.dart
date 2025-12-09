import 'package:flutter/material.dart';
import '../../config/app_text_styles.dart';
import '../providers/order_delivery/order_provider.dart';
import 'overall_orders.dart';

// Widgets
import '../widgets/order_details_page/common_back_button.dart';
import '../widgets/order_details_page/order_item_card.dart';
import '../widgets/order_details_page/action_button.dart';
import '../widgets/order_details_page/amount_section.dart';
import '../widgets/order_details_page/bottom_button.dart';
import '../widgets/order_details_page/delevery_button.dart';
import '../widgets/order_details_page/order_status_tracker.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String? deliveryChoice; // 👉 "self" or "partner"
  int currentStep = -1; // -1: Pending, 0: Confirmed, 1: Ready for Pickup
  bool _showStickyButton = false;

  void _showPickupConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Is the Order Ready for Pickup?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "No",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentStep = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = OrderProvider().getOrderItems();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: const Center(child: CommonBackButton()),
        centerTitle: true,
        title: Text(
          "Order Details",
          style: AppTextStyles.title.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.depth == 0 &&
                    (notification is ScrollUpdateNotification ||
                        notification is ScrollMetricsNotification)) {
                  final shouldShow =
                      notification.metrics.extentAfter > 20 &&
                      notification.metrics.maxScrollExtent > 0;
                  if (shouldShow != _showStickyButton) {
                    // Use addPostFrameCallback to avoid setState during build
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _showStickyButton = shouldShow;
                        });
                      }
                    });
                  }
                }
                return false;
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    /// ORDER STATUS TRACKER
                    OrderStatusTracker(
                      currentStep: currentStep,
                    ), // 0: Confirmed, 1: Ready for Pickup, etc.

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

                    /// ORDER ITEMS LIST
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 173 / 110,
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

                    if (currentStep == -1) ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: DeleveryButtons(
                          onDeliverySelected: (value) {
                            setState(() {
                              deliveryChoice = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 20,
                        ),
                        child: ActionButtons(
                          deliveryType: deliveryChoice,
                          onConfirm: () {
                            setState(() {
                              currentStep = 0;
                            });
                          },
                          onDecline: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OverallOrdersPage(
                                  showUndoSnackbar: true,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ] else if (currentStep == 0) ...[
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: BottomButton(
                          onTap: () => _showPickupConfirmation(context),
                        ),
                      ),
                    ] else if (currentStep == 1) ...[
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "The Order is Ready for Pickup",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_showStickyButton)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: currentStep == -1
                      ? ActionButtons(
                          deliveryType: deliveryChoice,
                          onConfirm: () {
                            setState(() {
                              currentStep = 0;
                            });
                          },
                          onDecline: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OverallOrdersPage(
                                  showUndoSnackbar: true,
                                ),
                              ),
                            );
                          },
                        )
                      : currentStep == 0
                      ? BottomButton(
                          onTap: () => _showPickupConfirmation(context),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
