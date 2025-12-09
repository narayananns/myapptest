import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thristoparnterapp/models/profile_page/store_time_model.dart';

class StoreTimeApiService {
  static String baseUrl = "https://your-backend.com";

  static Future saveStoreTime(StoreTimeModel model) async {
    await http.post(
      Uri.parse("$baseUrl/store-time"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(model.toJson()),
    );
  }

  static Future<StoreTimeModel?> getStoreTime() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    // Return mock data for now
    return StoreTimeModel(
      openTime: "09:00",
      closeTime: "21:00",
      totalHours: "12 hr 0 min",
    );
  }
}
