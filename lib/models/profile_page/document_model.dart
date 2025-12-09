class FolderModel {
  final String name;
  final String size;
  final String date;
  final String icon;

  FolderModel({
    required this.name,
    required this.size,
    required this.date,
    required this.icon,
  });

  // Convert to JSON for backend
  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "date": date,
    "icon": icon,
  };

  FolderModel copyWith({
    String? name,
    String? size,
    String? date,
    String? icon,
  }) {
    return FolderModel(
      name: name ?? this.name,
      size: size ?? this.size,
      date: date ?? this.date,
      icon: icon ?? this.icon,
    );
  }

  factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
    name: json["name"] ?? "",
    size: json["size"] ?? "",
    date: json["date"] ?? "",
    icon: json["icon"] ?? "",
  );
}
