import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_api.dart';


class DashboardProvider extends ChangeNotifier {
DashboardModel? model;
bool isLoading = false;
String? errorMessage;


final DashboardApi api;


DashboardProvider({DashboardApi? api}) : api = api ?? DashboardApi();


Future<void> loadDashboard() async {
isLoading = true;
errorMessage = null;
notifyListeners();


try {
model = await api.fetchDashboard();
} catch (e) {
errorMessage = e.toString();
}


isLoading = false;
notifyListeners();
}
}