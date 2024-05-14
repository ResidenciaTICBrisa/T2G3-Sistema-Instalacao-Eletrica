class PlaceResponseModel {
  int id;
  String name;
  double lon;
  double lat;
  int placeOwner;

  PlaceResponseModel({
    required this.id,
    required this.name,
    required this.lon,
    required this.lat,
    required this.placeOwner,
  });

  factory PlaceResponseModel.fromJson(Map<String, dynamic> json) {
    return PlaceResponseModel(
      id: json['id'],
      name: json['name'],
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
      placeOwner: json['place_owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lon': lon,
      'lat': lat,
      'place_owner': placeOwner,
    };
  }
}
