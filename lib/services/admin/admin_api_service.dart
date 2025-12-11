import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/admin/admin_dashboard_model.dart';

/// Admin API Service
/// Handles all API calls related to admin dashboard
/// Backend team should implement these endpoints:
/// 
/// GET /api/admin/dashboard
/// - Returns AdminDashboardModel data
/// 
/// PUT /api/admin/stores/{storeId}/status
/// - Updates store active status
/// - Body: { "isActive": true/false }
/// 
/// DELETE /api/admin/stores/{storeId}
/// - Deletes a store
/// 
/// GET /api/admin/stores
/// - Returns list of all stores

class AdminApiService {
  // TODO: Replace with actual backend base URL
  static const String baseUrl = 'https://your-backend-api.com/api/admin';

  /// Fetch admin dashboard data
  /// Expected response format:
  /// {
  ///   "storeLive": 11,
  ///   "totalSales": 0,
  ///   "totalOrders": 28,
  ///   "ordersPlacedToday": 0,
  ///   "stores": [
  ///     {
  ///       "id": "store1",
  ///       "name": "Supervek",
  ///       "logoUrl": "https://...",
  ///       "isActive": true,
  ///       "totalOrders": 10,
  ///       "totalSales": 50000
  ///     },
  ///     ...
  ///   ]
  /// }
  Future<AdminDashboardModel> fetchAdminDashboard() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard'),
        headers: {
          'Content-Type': 'application/json',
          // TODO: Add authentication token
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return AdminDashboardModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load dashboard: ${response.statusCode}',
        );
      }
    } catch (e) {
      // For development, return mock data
      // Remove this when backend is ready
      debugPrint('API Error: $e');
      return _getMockData();
    }
  }

  /// Update store status
  Future<void> updateStoreStatus(String storeId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/stores/$storeId/status'),
        headers: {
          'Content-Type': 'application/json',
          // TODO: Add authentication token
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'isActive': true, // This should be toggled based on current status
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to update store status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error updating store status: $e');
      rethrow;
    }
  }

  /// Delete a store
  Future<void> deleteStore(String storeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/stores/$storeId'),
        headers: {
          'Content-Type': 'application/json',
          // TODO: Add authentication token
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
          'Failed to delete store: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error deleting store: $e');
      rethrow;
    }
  }

  /// Get all stores
  Future<List<StoreModel>> getAllStores() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/stores'),
        headers: {
          'Content-Type': 'application/json',
          // TODO: Add authentication token
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final storesList = jsonData['stores'] as List<dynamic>;
        return storesList
            .map((store) => StoreModel.fromJson(store))
            .toList();
      } else {
        throw Exception(
          'Failed to load stores: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error loading stores: $e');
      return [];
    }
  }

  /// Mock data for development
  /// Remove this method when backend is ready
  AdminDashboardModel _getMockData() {
    return AdminDashboardModel(
      storeLive: 11,
      totalSales: 0,
      totalOrders: 28,
      ordersPlacedToday: 0,
      stores: [
        StoreModel(
          id: '1',
          name: 'Supervek',
          logoUrl: '',
          isActive: true,
        ),
        StoreModel(
          id: '2',
          name: 'Burger Bae',
          logoUrl: '',
          isActive: true,
        ),
        StoreModel(
          id: '3',
          name: 'Thristo',
          logoUrl: '',
          isActive: true,
        ),
        StoreModel(
          id: '4',
          name: 'Project Shades',
          logoUrl: '',
          isActive: true,
        ),
        StoreModel(
          id: '5',
          name: 'Home',
          logoUrl: '',
          isActive: true,
        ),
        StoreModel(
          id: '6',
          name: 'Profile',
          logoUrl: '',
          isActive: true,
        ),
      ],
    );
  }
}

