import 'package:flutter/material.dart';
import '../../models/admin/admin_dashboard_model.dart';
import '../../services/admin/admin_api_service.dart';

/// Admin Provider
/// Manages state for admin dashboard
/// Handles data fetching, loading states, and error handling
class AdminProvider extends ChangeNotifier {
  AdminDashboardModel? _dashboardData;
  bool _isLoading = false;
  String? _errorMessage;

  final AdminApiService _apiService;

  AdminProvider({AdminApiService? apiService})
      : _apiService = apiService ?? AdminApiService();

  // Getters
  AdminDashboardModel? get dashboardData => _dashboardData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasData => _dashboardData != null;

  /// Load admin dashboard data
  /// This method fetches data from the backend API
  Future<void> loadDashboard() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _dashboardData = await _apiService.fetchAdminDashboard();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Error loading admin dashboard: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh dashboard data
  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  /// Get store by ID
  StoreModel? getStoreById(String storeId) {
    if (_dashboardData == null) return null;
    try {
      return _dashboardData!.stores.firstWhere(
        (store) => store.id == storeId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Toggle store active status
  /// This method will call the backend API to update store status
  Future<void> toggleStoreStatus(String storeId) async {
    try {
      await _apiService.updateStoreStatus(storeId);
      // Reload dashboard after status change
      await loadDashboard();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// Delete store
  /// This method will call the backend API to delete a store
  Future<void> deleteStore(String storeId) async {
    try {
      await _apiService.deleteStore(storeId);
      // Reload dashboard after deletion
      await loadDashboard();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}

