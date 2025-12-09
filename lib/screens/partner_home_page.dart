import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/models/notification_model.dart';
import 'package:thristoparnterapp/providers/notifications/notification_controller.dart';
import 'package:thristoparnterapp/providers/profile_page/profile_provider.dart';
import '../providers/dashboard_home_provider.dart';
import '../widgets/partner_home_page/header.dart';
import '../widgets/partner_home_page/quick_actions.dart';
import '../widgets/partner_home_page/summary/summary_card.dart';
import '../widgets/partner_home_page/summary/products_live_card.dart';
import '../widgets/partner_home_page/glance/store_at_glance.dart';
import '../widgets/partner_home_page/shipment_alert.dart';

class PartnerHomePage extends StatefulWidget {
  const PartnerHomePage({super.key});

  @override
  State<PartnerHomePage> createState() => _PartnerHomePageState();
}

class _PartnerHomePageState extends State<PartnerHomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final model = provider.model;
    final int pendingShipments = model?.pendingShipments ?? 0;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: Header(storeName: partnerProvider.partner.storeName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = Provider.of<NotificationController>(
            context,
            listen: false,
          );

          controller.addNotification(
            NotificationModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              customerName: "Preview Customer",
              orderId: "ORDER2025",
              productName: "Zara Women Dress",
              quantity: 2,
              isNew: true,
              status: "pending",
              type: "order",
              timestamp: DateTime.now(),
              brandName: "Thristo",
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: RefreshIndicator(
        onRefresh: provider.loadDashboard,
        color: theme.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              if (pendingShipments > 0)
                ShipmentAlert(pendingShipments: pendingShipments),
              if (pendingShipments > 0) const SizedBox(height: 20),

              const QuickActions(),
              const SizedBox(height: 30),

              _buildStoreSummary(provider, theme),
              const SizedBox(height: 30),

              // pass model to StoreAtGlance (theme-aware)
              StoreAtGlance(model: model),
              const SizedBox(height: 40),

              if (provider.isLoading)
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                  ),
                ),

              if (provider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    provider.errorMessage!,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomNav(context, theme),
    );
  }

  Widget _buildBottomNav(BuildContext context, ThemeData theme) {
    return BottomNavigationBar(
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
      currentIndex: currentIndex,
      selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,

      onTap: (index) {
        if (index == currentIndex) return;
        setState(() => currentIndex = index);

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/analytics');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },

      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildStoreSummary(DashboardProvider provider, ThemeData theme) {
    final model = provider.model;
    final textTheme = theme.textTheme;
    final titleStyle =
        textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold) ??
        TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
        );

    final accentStyle = titleStyle.copyWith(color: theme.primaryColor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Your ', style: titleStyle),
            Text('Store ', style: accentStyle),
            Text('Summary', style: titleStyle),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: 'Total Sales',
                value: model?.totalSalesFormatted ?? '-',
                revenueText: 'Revenue Growth',
                growthText: model?.growthText ?? '-',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ProductsLiveCard(
                count: model?.productsLive ?? 0,
                status: model?.productsLiveStatus ?? 'Unknown',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
