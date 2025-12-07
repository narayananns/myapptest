import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thristoparnterapp/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../models/profile_page/theme_provider.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/menu_card.dart';
import 'package:thristoparnterapp/widgets/partner_profile_page/profile_header.dart';
import 'overall_orders.dart';

class PartnerProfilePage extends StatelessWidget {
  const PartnerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PartnerProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Future<void> _refreshData() async {
      await provider.refreshPartner();
    }

    void _showEditDialog(BuildContext context, PartnerProvider provider) {
      final nameController = TextEditingController(
        text: provider.partner.storeName,
      );
      String? tempImagePath = provider.partner.profileImage;
      final ImagePicker picker = ImagePicker();

      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Profile"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          tempImagePath = image.path;
                        });
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: tempImagePath!.startsWith('assets/')
                              ? AssetImage(tempImagePath!) as ImageProvider
                              : FileImage(File(tempImagePath!)),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        ),
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Store Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.updatePartner(
                      name: nameController.text,
                      imagePath: tempImagePath,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        ),
      );
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
                  onEdit: () => _showEditDialog(context, provider),
                ),

                const SizedBox(height: 10),

                /// Menu Grid
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  children: [
                    MenuCard(
                      title: "My Orders",
                      imagePath: "assets/images/order icon.png",
                      showDot: true,
                      navigateTo: const OverallOrdersPage(),
                    ),
                    MenuCard(
                      title: "Store\nTimings",
                      imagePath: "assets/images/store timings.png",
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Store\nDocument",
                      imagePath: "assets/images/store document.png",
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Store Bank\nDetails",
                      imagePath: "assets/images/store bank details.png",
                      showDot: true,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "My\nPayments",
                      imagePath: "assets/images/my payments.png",
                      showDot: true,
                      // navigateTo: ,
                    ),
                    MenuCard(
                      title: "Monthly\nInvoice",
                      imagePath: "assets/images/monthly invoice.png",
                      // navigateTo: ,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

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
                        // ensure contrast using onPrimary
                        color: colorScheme.onPrimary,
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
    return AppBar(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      elevation: theme.appBarTheme.elevation ?? 10,
      scrolledUnderElevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: const Text(
        "Profile",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
      ),
      actions: [
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            final isDark = themeProvider.isDark;
            return IconButton(
              onPressed: () => themeProvider.toggleTheme(),
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
                size: 28,
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
      selectedItemColor:
          theme.bottomNavigationBarTheme.selectedItemColor ??
          theme.primaryColor,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: theme.iconTheme.color),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, color: theme.iconTheme.color),
          label: "Analytics",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: theme.iconTheme.color),
          label: "Profile",
        ),
      ],
    );
  }
}
