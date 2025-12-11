import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thristoparnterapp/providers/profile_page/profile_provider.dart';
import 'package:thristoparnterapp/providers/notifications/notification_controller.dart';
import 'package:thristoparnterapp/providers/profile_page/store_time_controller.dart';
import '../../screens/profile_page/partner_profile_page.dart';
import '../../screens/notification_panel_screen.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String storeName;

  const Header({super.key, required this.storeName});

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final storeTimeCtrl = Provider.of<StoreTimeController>(context);
    final profileImage = partnerProvider.partner.profileImage;

    // Mock status for now (Offline/Online)
    const String storeStatus = "Offline";

    return AppBar(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: _getImageProvider(profileImage),
                  onBackgroundImageError: (_, __) {
                    // Fallback handled by showing nothing or default background color
                  },
                ),
              ),
              const SizedBox(width: 12),

              /// Store Name and Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      storeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          storeStatus,
                          style: TextStyle(
                            color: storeStatus == "Online"
                                ? Colors.blue
                                : Colors.yellow,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "|",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          storeTimeCtrl.isStoreOpen ? "Open" : "Closed",
                          style: TextStyle(
                            color: storeTimeCtrl.isStoreOpen
                                ? Colors.green
                                : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
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
                icon: const Icon(
                  Icons.person_outline,
                  size: 28,
                  color: Colors.white,
                ),
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
  Size get preferredSize => const Size.fromHeight(80);
}
