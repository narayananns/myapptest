import 'package:flutter/material.dart';
import 'package:thristoparnterapp/main.dart';

import '../../models/notification_model.dart';
import 'notification_sound_handler.dart';
import '../../widgets/notification_card/slide_notification_popup.dart';

class NotificationController extends ChangeNotifier {
  List<NotificationModel> notifications = [];

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void loadNotifications(List<NotificationModel> data) {
    isLoading = false;
    notifications = data;
    _sortByLatest();
    notifyListeners();
  }

  void addNotification(NotificationModel newNotification) {
    notifications.insert(0, newNotification);
    _sortByLatest();

    if (newNotification.playSound == true ||
        newNotification.vibrate == true) {
      NotificationSoundHandler.playAlert();
    }

    final ctx = navigatorKey.currentContext ??
        navigatorKey.currentState?.overlay?.context;

    if (ctx != null) {
      SlideNotificationPopup.show(
        ctx,
        "New Order",
        "${newNotification.customerName} placed an order.",
      );
    }

    notifyListeners();
  }

  void updateStatus(String id, String newStatus) {
    final index = notifications.indexWhere((e) => e.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(
        status: newStatus,
        isNew: false,
      );
      notifyListeners();
    }
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((e) => e.id == id);
    if (index != -1) {
      notifications[index] =
          notifications[index].copyWith(isNew: false);
      notifyListeners();
    }
  }

  void markAllRead() {
    notifications =
        notifications.map((n) => n.copyWith(isNew: false)).toList();
    notifyListeners();
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void clearAll() {
    notifications.clear();
    notifyListeners();
  }

  int get unreadCount =>
      notifications.where((n) => n.isNew == true).length;

  void _sortByLatest() {
    notifications.sort(
      (a, b) => b.timestamp.compareTo(a.timestamp),
    );
  }
}
