import 'package:flutter/material.dart';

/// Admin Header Widget
/// Displays the app name "Thristo" with shopping bag and profile icons
class AdminHeader extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const AdminHeader({
    super.key,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App Name
              const Text(
                'Thristo',
                style: TextStyle(
                  color: Color(0xFF4DD0E1), // Light blue-green color
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),

              // Right side icons
              Row(
                children: [
                  // Shopping bag with notification badge
                  Stack(
                    children: [
                      IconButton(
                        onPressed: onNotificationTap ?? () {},
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Color(0xFF81C784), // Light green
                          size: 28,
                        ),
                      ),
                      if (notificationCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Center(
                              child: Text(
                                notificationCount > 99 ? '99+' : '$notificationCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // Profile icon
                  IconButton(
                    onPressed: onProfileTap ?? () {},
                    icon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF81C784), // Light green
                      size: 28,
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
  Size get preferredSize => const Size.fromHeight(80);
}

