class AreaRequestModel {
  String name;
  int? floor;
  int? place;

  AreaRequestModel({required this.name, this.floor, this.place});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'floor': floor,
      'place': place,
    };
  }

  factory AreaRequestModel.fromJson(Map<String, dynamic> json) {
    return AreaRequestModel(
      name: json['name'],
      floor: json['floor'],
      place: json['place'],
    );
  }
}
