import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_provider.dart';

import '../providers/analytics_provider.dart';
import '../widgets/partner_home_page/header.dart';
import '../widgets/partner_analytics_page/bottom_nav.dart';
import '../widgets/partner_analytics_page/summary_card.dart';
import '../widgets/partner_analytics_page/traffic_card.dart';
import '../widgets/partner_analytics_page/revenue_chart.dart';

class PartnerAnalyticsPage extends StatefulWidget {
  const PartnerAnalyticsPage({super.key});

  @override
  State<PartnerAnalyticsPage> createState() => _PartnerAnalyticsPageState();
}

class _PartnerAnalyticsPageState extends State<PartnerAnalyticsPage> {
  @override
  void initState() {
    super.initState();

    // Load analytics data when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AnalyticsProvider>();
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      // use theme scaffold background
      backgroundColor: theme.scaffoldBackgroundColor,

      // APP BAR (theme-aware)
      appBar: Header(storeName: partnerProvider.partner.storeName),

      // BOTTOM NAV (use widget that accepts currentIndex)
      bottomNavigationBar: const PartnerBottomNav(currentIndex: 1),

      // BODY WITH REFRESH
      body: RefreshIndicator(
        onRefresh: provider.refresh,
        color: theme.primaryColor,
        child: provider.loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                ),
              )
            : provider.error != null
            ? _buildError(provider.error!, theme)
            : _buildBody(context, provider, theme),
      ),
    );
  }

  // ERROR WIDGET
  Widget _buildError(String error, ThemeData theme) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 150),
        Center(
          child: Text(
            "Error: $error",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.error,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  // MAIN BODY
  Widget _buildBody(
    BuildContext context,
    AnalyticsProvider provider,
    ThemeData theme,
  ) {
    if (provider.data == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(theme.primaryColor),
          ),
        ),
      );
    }

    final data = provider.data!;
    final textTheme = theme.textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      children: [
        // PAGE TITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Analytics ",
              style:
                  textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: theme.primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "Summary",
              style:
                  textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: theme.colorScheme.onBackground,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // SUMMARY CARDS
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
          children: [
            SummaryCard(
              title: "Total Sales",
              value: data.totalSalesLabel,
              subtitle: "Amount Total",
              valueColor: Colors.blue,
            ),
            SummaryCard(
              title: "Active Users",
              value: "${data.activeUsers}k",
              subtitle: "Active",
              valueColor: Colors.white,
              trailing: const Text(
                "+110",
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SummaryCard(
              title: "Revenue Growth",
              value: "${data.revenueGrowth}",
              subtitle: "Avg.Order Value",
              valueColor: Colors.white,
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "+110",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SummaryCard(
              title: "Conversion Rate",
              value: "${data.conversionRate.toStringAsFixed(1)}%",
              subtitle: "Avr.Stats",
              valueColor: Colors.white,
              trailing: const Icon(
                Icons.favorite,
                color: Colors.deepPurpleAccent,
                size: 35,
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // TRAFFIC TITLE
        Text(
          "Traffic & Engagement",
          style:
              textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ) ??
              TextStyle(
                color: theme.colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),

        // TRAFFIC CARDS
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.25,
          ),
          children: [
            TrafficCard(
              title: "Store Page Visit",
              value: "+${data.storePageVisits ~/ 1000}k",
              subtitle: "Avr. Customer Rate",
              changeLabel: "+150",
              valueColor: Colors.blue,
            ),
            TrafficCard(
              title: "Wishlist Items",
              value: "${data.wishlistItems}",
              subtitle: "New Customers",
              changeLabel: "+15",
            ),
          ],
        ),

        const SizedBox(height: 20),

        // GRAPH CARD
        Card(
          color: const Color.fromRGBO(36, 36, 36, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.08),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Revenue Last 30 Days",
                  style:
                      textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ) ??
                      TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: RevenueChart(points: data.revenueLast30Days),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
