import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notifications/notification_controller.dart';
import '../widgets/notification_card/notification_card.dart';
import '../widgets/notification_card/shimmer_notification_card.dart';

class NotificationPanelScreen extends StatelessWidget {
  const NotificationPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),

        actions: [
          Consumer<NotificationController>(
            builder: (context, con, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Do nothing (we are already in this screen)
                  },
                ),

                if (con.unreadCount > 0)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        con.unreadCount.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Consumer<NotificationController>(
        builder: (context, controller, _) {
          final notifications = controller.notifications;

          // ✔ Case 1: FIRST LOAD → Shimmer
          if (controller.isLoading) {
            return ListView.builder(
              itemCount: 6,
              itemBuilder: (_, __) => const ShimmerNotificationCard(),
            );
          }

          // ✔ Case 2: No notifications
          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications available",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // ✔ Case 3: Show actual list
          return RefreshIndicator(
            onRefresh: () async {
              controller.loadNotifications(controller.notifications);
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final data = notifications[index];

                return NotificationCard(
                  data: data,
                  onTap: () {
                    controller.updateStatus(data.id, "pending");
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
