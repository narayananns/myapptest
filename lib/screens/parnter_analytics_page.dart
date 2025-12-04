import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_provider.dart';

import '../providers/analytics_provider.dart';
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
    final partnerProvider = context.watch<PartnerProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final iconColor = theme.iconTheme.color;

    return Scaffold(
      // use theme scaffold background
      backgroundColor: theme.scaffoldBackgroundColor,

      // APP BAR (theme-aware)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 10,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        partnerProvider.partner.profileImage.startsWith(
                          'assets/',
                        )
                        ? AssetImage(partnerProvider.partner.profileImage)
                              as ImageProvider
                        : FileImage(File(partnerProvider.partner.profileImage)),
                    backgroundColor: theme.cardColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      partnerProvider.partner.storeName,
                      style:
                          textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ) ??
                          TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: iconColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person_outline, color: iconColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

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
        const SizedBox(height: 20),

        // PAGE TITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Analytics ",
              style:
                  textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ) ??
                  TextStyle(
                    color: theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              "Summary",
              style:
                  textTheme.titleMedium?.copyWith(
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
            ),
            SummaryCard(
              title: "Active Users",
              value: "${data.activeUsers}k",
              subtitle: "Active",
              trailing: Text(
                "+110",
                style:
                    textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                    ) ??
                    const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 22,
                    ),
              ),
            ),
            SummaryCard(
              title: "Revenue Growth",
              value: "${data.revenueGrowth}",
              subtitle: "Avg.Order Value",
              trailing: Text(
                "+110",
                style:
                    textTheme.titleLarge?.copyWith(color: theme.primaryColor) ??
                    const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 22,
                    ),
              ),
            ),
            SummaryCard(
              title: "Conversion Rate",
              value: "${data.conversionRate.toStringAsFixed(1)}%",
              subtitle: "Avr.Stats",
              trailing: Icon(
                Icons.favorite,
                color: theme.colorScheme.secondary,
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
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ) ??
              TextStyle(
                color: theme.colorScheme.onBackground,
                fontSize: 22,
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
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
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
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ) ??
                      TextStyle(
                        color: theme.colorScheme.onBackground,
                        fontSize: 26,
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
