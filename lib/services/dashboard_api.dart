import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';


class DashboardApi {
final String baseUrl;


DashboardApi({this.baseUrl = ''});


/// Replace this with your real API call. For now it tries to fetch from [baseUrl]/dashboard
/// If baseUrl is empty it loads a local sample JSON located at assets/sample_dashboard.json (useful for dev).
Future<DashboardModel> fetchDashboard() async {
if (baseUrl.isEmpty) {
final raw = await rootBundle.loadString('assets/sample_dashboard.json').catchError((_) => '{}');
final Map<String, dynamic> data = json.decode(raw) as Map<String, dynamic>;
return DashboardModel.fromJson(data);
}


final url = Uri.parse('$baseUrl/dashboard');
final resp = await http.get(url).timeout(const Duration(seconds: 10));
if (resp.statusCode == 200) {
final Map<String, dynamic> data = json.decode(resp.body) as Map<String, dynamic>;
return DashboardModel.fromJson(data);
}


throw Exception('Failed to load dashboard: ${resp.statusCode}');
}
}