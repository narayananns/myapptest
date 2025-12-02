import 'dart:async';
import '../models/analytics_model.dart';
class ApiService {
  // Simulated network call - replace with real HTTP call later.
  static Future<AnalyticsModel> fetchAnalytics() async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Simulated response (replace with real backend values)
    final model = AnalyticsModel(
      storeName: 'Wild Musafir Clothing',
      totalSalesAmount: 185000,
      totalSalesLabel: '₹ 1,85,000',
      revenueGrowth: '3.2k',
      conversionRate: 2.5,
      wishlistItems: 45,
      storePageVisits: 15000,
      activeUsers: 3, // NEW: 3k shown as "3k" in UI if you use suffix
      revenueLast30Days: [30, 180, 60, 210, 120, 200],
    );

    return model;
  }
}
