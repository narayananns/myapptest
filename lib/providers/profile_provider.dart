import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thristoparnterapp/models/profile_page/partner_profile_model.dart';

class PartnerProvider with ChangeNotifier {
  PartnerProfileModel partner = PartnerProfileModel(
    storeName: "Wild Musafir Clothing",
    profileImage: "assets/images/zoro.jpg",
  );

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery and update profile
  Future<void> updateProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        partner = PartnerProfileModel(
          storeName: partner.storeName,
          profileImage: image.path,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  /// Update store name
  void updateStoreName(String newName) {
    partner = PartnerProfileModel(
      storeName: newName,
      profileImage: partner.profileImage,
    );
    notifyListeners();
  }

  /// Update both name and image path directly (useful for dialogs)
  void updatePartner({String? name, String? imagePath}) {
    partner = PartnerProfileModel(
      storeName: name ?? partner.storeName,
      profileImage: imagePath ?? partner.profileImage,
    );
    notifyListeners();
  }

  /// Dummy refresh method
  Future<void> refreshPartner() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Example: update partner info (here we keep same data)
    // In a real app, you would fetch from API
    // partner = PartnerProfileModel(
    //   storeName: "Wild Musafir Clothing",
    //   profileImage: "assets/profile.jpg",
    // );

    notifyListeners(); // notify widgets to rebuild
  }
}
