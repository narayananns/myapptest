import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_provider.dart';
import 'package:thristoparnterapp/providers/notifications/notification_controller.dart';
import '../../screens/partner_profile_page.dart';
import '../../screens/notification_panel_screen.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String storeName;

  const Header({super.key, required this.storeName});

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final profileImage = partnerProvider.partner.profileImage;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 4,
      automaticallyImplyLeading: false,
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
                backgroundImage: _getImageProvider(profileImage),
                onBackgroundImageError: (_, __) {
                  // Fallback handled by showing nothing or default background color
                },
              ),
              const SizedBox(width: 12),

              /// Store Name
              Expanded(
                child: Text(
                  storeName,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              /// Notification button
              Consumer<NotificationController>(
                builder: (context, notifCtrl, child) {
                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationPanelScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (notifCtrl.unreadCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${notifCtrl.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              /// Profile button
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PartnerProfilePage(),
                    ),
                  );
                },
                icon: Icon(Icons.person_outline, color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
