class FolderModel {
  final String name;
  final String size;
  final String date;
  final String icon;
  final String? filePath;

  FolderModel({
    required this.name,
    required this.size,
    required this.date,
    required this.icon,
    this.filePath,
  });

  // Convert to JSON for backend
  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "date": date,
    "icon": icon,
    "filePath": filePath,
  };

  FolderModel copyWith({
    String? name,
    String? size,
    String? date,
    String? icon,
    String? filePath,
  }) {
    return FolderModel(
      name: name ?? this.name,
      size: size ?? this.size,
      date: date ?? this.date,
      icon: icon ?? this.icon,
      filePath: filePath ?? this.filePath,
    );
  }

  factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
    name: json["name"] ?? "",
    size: json["size"] ?? "",
    date: json["date"] ?? "",
    icon: json["icon"] ?? "",
    filePath: json["filePath"],
  );
}
