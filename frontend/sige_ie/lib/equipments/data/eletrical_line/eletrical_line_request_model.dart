class EletricalLineRequestModel {
  int? area;
  int? system;

  EletricalLineRequestModel({
    required this.area,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'system': system,
    };
  }
}
