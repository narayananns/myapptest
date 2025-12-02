import 'package:flutter/foundation.dart';
import '../models/analytics_model.dart';
import '../services/analytics_api_service.dart';

class AnalyticsProvider extends ChangeNotifier {
  bool _loading = false;
  AnalyticsModel? _data;
  String? _error;

  bool get loading => _loading;
  AnalyticsModel? get data => _data;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ApiService.fetchAnalytics();
      _data = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // convenience method to force refresh (e.g., pull-to-refresh)
  Future<void> refresh() => load();
}
