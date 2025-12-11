import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin/admin_provider.dart';
import '../../models/admin/admin_dashboard_model.dart';
import '../../widgets/admin/admin_header.dart';
import '../../widgets/admin/metric_card.dart';
import '../../widgets/admin/orders_today_card.dart';
import '../../widgets/admin/store_grid_item.dart';
import '../../widgets/admin/admin_bottom_nav.dart';
import '../profile_page/partner_profile_page.dart';

/// Admin Dashboard Screen
/// Main screen for admin to manage all stores
/// Displays metrics, orders, and store grid
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load dashboard data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey.shade100,
      appBar: const AdminHeader(notificationCount: 0),
      body: Consumer<AdminProvider>(
        builder: (context, adminProvider, child) {
          if (adminProvider.isLoading && adminProvider.dashboardData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (adminProvider.errorMessage != null &&
              adminProvider.dashboardData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading dashboard',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    adminProvider.errorMessage!,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => adminProvider.loadDashboard(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final dashboardData = adminProvider.dashboardData;
          if (dashboardData == null) {
            return const Center(child: Text('No data available'));
          }

          return RefreshIndicator(
            onRefresh: () => adminProvider.refreshDashboard(),
            color: theme.primaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Metric Cards Carousel Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MetricCard(
                          title: 'Store Live',
                          value: '${dashboardData.storeLive}',
                          icon: Icons.wifi,
                        ),
                        const SizedBox(
                          width: 16,
                        ), // same gap between first & second
                        MetricCard(
                          title: 'Total sales',
                          value: dashboardData.totalSalesFormatted,
                          icon: Icons.local_offer,
                        ),
                        const SizedBox(width: 28), // larger gap before third
                        MetricCard(
                          title: 'Total orders',
                          value: '${dashboardData.totalOrders}',
                          icon: Icons.shopping_bag,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Orders Placed Today Card
                  OrdersTodayCard(
                    ordersPlacedToday: dashboardData.ordersPlacedToday,
                  ),
                  const SizedBox(height: 24),

                  // Stores Grid Section
                  Text(
                    'Stores',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stores Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 4,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: dashboardData.stores.length,
                    itemBuilder: (context, index) {
                      final store = dashboardData.stores[index];
                      return StoreGridItem(
                        store: store,
                        onTap: () {
                          // Navigate to store details or manage store
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PartnerProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
