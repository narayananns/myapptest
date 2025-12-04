import 'package:flutter/material.dart';
import '../../../models/dashboard_home_model.dart';
import 'glance/glance_circular_card.dart';
import 'glance/glance_icon_card.dart';
import 'glance/glance_percent_card.dart';

class StoreAtGlance extends StatelessWidget {
  final DashboardModel? model;
  const StoreAtGlance({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600) ??
        TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: colorScheme.onBackground);

    // choose accent colors from theme (fall back to sensible defaults)
    final accent = theme.primaryColor;
    final subtleText = colorScheme.onBackground.withOpacity(0.9);
    final percentAccent = theme.colorScheme.secondary ?? theme.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with theme-aware colors
        Row(
          children: [
            Text('Your ', style: titleStyle.copyWith(color: subtleText)),
            Text('Store ', style: titleStyle.copyWith(color: accent)),
            Text('At Glance', style: titleStyle.copyWith(color: subtleText)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GlanceCircularCard(
                title: 'Order Placed',
                centerNumber: (model?.orderPlaced ?? 0).toString(),
                percent: 0.7,
                footerMain: (model?.storePageVisits ?? 0).toString(),
                footerSub: '+200 today',
                // let child pick sensible colors if it accepts them; otherwise children should be theme-aware
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlanceIconCard(
                title: 'Total Orders',
                centerNumber: (model?.totalOrders ?? 0).toString(),
                centerIcon: Icons.trending_up,
                // use theme primary/accent for icon color
                centerIconColor: accent,
                footerMain: 'Analytical Node',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlancePercentCard(
                title: 'Store Page Visit',
                centerNumber: (model?.storePageVisits ?? 0).toString(),
                percentText: '+10%',
                // use theme secondary/primary for percent indicator
                percentColor: percentAccent,
                footerMain: 'VS Last Month',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
