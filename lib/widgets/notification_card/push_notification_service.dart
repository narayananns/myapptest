import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../models/notification_model.dart';
import '../../providers/notifications/notification_controller.dart';
import '../../providers/notifications/notification_sound_handler.dart';
import 'slide_notification_popup.dart';
import '../../../main.dart'; // MUST CONTAIN navigatorKey

class PushNotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initNotifications(NotificationController controller) async {
    await messaging.requestPermission();
    await messaging.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message, controller, isFromForeground: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message, controller, isFromForeground: false);
    });

    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage, controller, isFromForeground: false);
    }
  }

  void _handleMessage(
    RemoteMessage message,
    NotificationController controller, {
    required bool isFromForeground,
  }) {
    final data = message.data;

    final notification = NotificationModel(
      id: data["id"]?.toString() ?? "",
      customerName: data["customer_name"] ?? "",
      orderId: data["order_id"]?.toString() ?? "",
      productName: data["product_name"] ?? "",
      quantity: _parseInt(data["quantity"]),
      isNew: true,
      status: data["status"] ?? "pending",
      type: data["type"] ?? "order",
      timestamp: DateTime.tryParse(data["timestamp"] ?? "") ?? DateTime.now(),
      brandName: data["brand_name"] ?? "Thristo",
      playSound: data["play_sound"]?.toString() != "false",
      vibrate: data["vibrate"]?.toString() != "false",
    );

    controller.addNotification(notification);

    // SAFE popup condition
    final ctx = navigatorKey.currentContext;

    if (isFromForeground && ctx != null) {
      SlideNotificationPopup.show(
        ctx,
        "New Order",
        "${notification.customerName} placed an order.",
      );
    }
  }

  int _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
