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

  PlaceRequestModel.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        lon = json['lon'].toDouble(),
        lat = json['lat'].toDouble();
}
