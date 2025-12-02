import 'package:flutter/material.dart';
import 'package:thristoparnterapp/models/profile_page/partner_profile_model.dart';

class PartnerProvider with ChangeNotifier {
  PartnerProfileModel partner = PartnerProfileModel(
    storeName: "Wild Musafir Clothing",
    profileImage: "assets/profile.jpg",
  );

  /// Dummy refresh method
  Future<void> refreshPartner() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Example: update partner info (here we keep same data)
    partner = PartnerProfileModel(
      storeName: "Wild Musafir Clothing", // You could fetch updated info here
      profileImage: "assets/profile.jpg",
    );

    notifyListeners(); // notify widgets to rebuild
  }
}
