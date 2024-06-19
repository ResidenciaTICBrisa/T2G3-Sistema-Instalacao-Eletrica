class IluminationRequestModel {
  int? area;
  int? system;

  IluminationRequestModel({
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
