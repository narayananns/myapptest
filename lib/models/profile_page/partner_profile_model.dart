class PartnerProfileModel {
  final String storeName;
  final String profileImage;

  PartnerProfileModel({required this.storeName, required this.profileImage});

  factory PartnerProfileModel.fromJson(Map<String, dynamic> json) {
    return PartnerProfileModel(
      storeName: json['store_name'] ?? '',
      profileImage: json['profile_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'store_name': storeName, 'profile_image': profileImage};
  }
}
