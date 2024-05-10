class RoomRequestModel {
  String name;
  int? floor;
  int? place;

  RoomRequestModel({required this.name, this.floor, this.place});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'floor': floor,
      'place': place,
    };
  }

  factory RoomRequestModel.fromJson(Map<String, dynamic> json) {
    return RoomRequestModel(
      name: json['name'],
      floor: json['floor'],
      place: json['place'],
    );
  }
}
