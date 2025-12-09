class StoreTimeModel {
  final String openTime;
  final String closeTime;
  final String totalHours;

  StoreTimeModel({
    required this.openTime,
    required this.closeTime,
    required this.totalHours,
  });

  Map<String, dynamic> toJson() => {
        "openTime": openTime,
        "closeTime": closeTime,
        "totalHours": totalHours,
      };
}
