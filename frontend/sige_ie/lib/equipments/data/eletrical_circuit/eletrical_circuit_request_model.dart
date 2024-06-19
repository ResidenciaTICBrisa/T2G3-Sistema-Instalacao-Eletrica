class EletricalCircuitRequestModel {
  int? area;
  int? system;

  EletricalCircuitRequestModel({
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
