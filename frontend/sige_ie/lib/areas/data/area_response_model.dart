class AreaResponseModel {
  int id;
  String name;
  int? floor;
  int place;

  AreaResponseModel({
    required this.id,
    required this.name,
    this.floor,
    required this.place,
  });

  factory AreaResponseModel.fromJson(Map<String, dynamic> json) {
    return AreaResponseModel(
      id: json['id'],
      name: json['name'],
      floor: json['floor'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'floor': floor,
      'place': place,
    };
  }
}
