import 'package:flutter/material.dart';
import 'package:thristoparnterapp/models/profile_page/store_time_model.dart';
import 'package:thristoparnterapp/services/store_time_api.dart';

class StoreTimeController extends ChangeNotifier {
  TimeOfDay openTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay closeTime = const TimeOfDay(hour: 5, minute: 30);

  String get totalHours {
    final open = Duration(hours: openTime.hour, minutes: openTime.minute);
    final close = Duration(hours: closeTime.hour, minutes: closeTime.minute);
    Duration diff = close - open;

    if (diff.isNegative) diff += const Duration(hours: 24);
    return "${diff.inHours} hr ${(diff.inMinutes % 60)} min";
  }

  void updateOpenTime(TimeOfDay value) {
    openTime = value;
    notifyListeners();
  }

  void updateCloseTime(TimeOfDay value) {
    closeTime = value;
    notifyListeners();
  }

  bool get isStoreOpen {
    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;
    final openMinutes = openTime.hour * 60 + openTime.minute;
    final closeMinutes = closeTime.hour * 60 + closeTime.minute;

    if (openMinutes < closeMinutes) {
      return currentMinutes >= openMinutes && currentMinutes <= closeMinutes;
    } else {
      // Overnight case (e.g. 10 PM to 2 AM)
      return currentMinutes >= openMinutes || currentMinutes <= closeMinutes;
    }
  }

  String get remainingOpenTime {
    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;
    final closeMinutes = closeTime.hour * 60 + closeTime.minute;

    int diff = closeMinutes - currentMinutes;
    if (diff < 0) {
      diff += 24 * 60;
    }

    return "${diff ~/ 60} hr ${diff % 60} min";
  }

  String get remainingClosedTime {
    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;
    final openMinutes = openTime.hour * 60 + openTime.minute;

    int diff = openMinutes - currentMinutes;
    if (diff < 0) {
      diff += 24 * 60;
    }

    return "${diff ~/ 60} hr ${diff % 60} min";
  }

  StoreTimeModel getTimeModel() {
    return StoreTimeModel(
      openTime: "${openTime.hour}:${openTime.minute}",
      closeTime: "${closeTime.hour}:${closeTime.minute}",
      totalHours: totalHours,
    );
  }

  Future<void> loadStoreTime() async {
    final model = await StoreTimeApiService.getStoreTime();
    if (model != null) {
      openTime = _parseTime(model.openTime);
      closeTime = _parseTime(model.closeTime);
      notifyListeners();
    }
  }

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
