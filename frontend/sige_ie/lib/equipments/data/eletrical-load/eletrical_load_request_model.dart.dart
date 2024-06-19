class EletricalLoadRequestModel {
  int? area;
  int? system;

  EletricalLoadRequestModel({
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
