class PlaceRequestModel {
  String name;
  double lon;
  double lat;

  PlaceRequestModel({required this.name, required this.lon, required this.lat});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lon': lon,
      'lat': lat,
    };
  }

  factory PlaceRequestModel.fromJson(Map<String, dynamic> json) {
    return PlaceRequestModel(
      name: json['name'],
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}
