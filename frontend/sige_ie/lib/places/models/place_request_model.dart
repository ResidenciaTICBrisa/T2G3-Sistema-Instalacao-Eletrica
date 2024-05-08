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
}
