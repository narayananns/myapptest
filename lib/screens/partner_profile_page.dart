import 'package:flutter/material.dart';
import 'package:thristoparnterapp/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../models/profile_page/theme_provider.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/menu_card.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/profile_header.dart';
import 'order_details_page.dart';

class PartnerProfilePage extends StatelessWidget {
  const PartnerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    Future<void> _refreshData() async {
      await provider.refreshPartner();
    }

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: theme.scaffoldBackgroundColor,

      // theme-aware bottom nav
      bottomNavigationBar: _bottomNav(context),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          // use theme primaryColor for refresh indicator
          color: theme.primaryColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Profile Section
                ProfileHeader(
                  name: provider.partner.storeName,
                  image: provider.partner.profileImage,
                ),

                const SizedBox(height: 30),

                /// Menu Grid
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.1,
                  ),
                  children: [
                    MenuCard(
                      title: "My Orders",
                      icon: Icons.shopping_cart,
                      showDot: true,
                      navigateTo: const OrderDetailsPage(),
                    ),
                    MenuCard(
                      title: "Store Timings",
                      icon: Icons.access_time,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Store Document",
                      icon: Icons.insert_drive_file,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Store Bank Details",
                      icon: Icons.account_balance_wallet,
                      showDot: true,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "My Payments",
                      icon: Icons.payments,
                      showDot: true,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Monthly Invoice",
                      icon: Icons.receipt_long,
                      // navigateTo: ,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// Logout Button - uses theme primary color
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor, // theme-aware
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        // ensure contrast using onPrimary if available, else fall back
                        color: colorScheme.onPrimary ?? (isDark ? Colors.black : Colors.white),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;
    final colorScheme = theme.colorScheme;
    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.transparent,
      elevation: theme.appBarTheme.elevation ?? 10,
      centerTitle: true,
      title: Text("Profile", style: theme.textTheme.titleMedium),
      leading: IconButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        icon: Icon(Icons.arrow_back, color: iconColor),
      ),
      actions: [
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            final isDark = themeProvider.isDark;
            return IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: iconColor,
              ),
              tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
            );
          },
        ),
      ],
    );
  }

  Widget _bottomNav(BuildContext context) {
    const int currentIndex = 2; // Profile page index
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor ?? theme.primaryColor,
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,

      onTap: (index) {
        if (index == currentIndex) return; // Prevent reloading same page

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
        BottomNavigationBarItem(icon: Icon(Icons.home, color: theme.iconTheme.color), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart, color: theme.iconTheme.color), label: "Analytics"),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: theme.iconTheme.color), label: "Profile"),
      ],
    );
  }
}
