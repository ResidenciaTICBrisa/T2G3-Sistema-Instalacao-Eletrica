class IluminationRequestModel {
  int? area;
  int? system;

  IluminationRequestModel({
    required this.area,
    required this.system,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': area,
      'system': system,
    };
  }
}
