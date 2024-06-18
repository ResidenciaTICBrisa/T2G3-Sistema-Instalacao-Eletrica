class AtmosphericRequestModel {
  int? area;
  int? system;

  AtmosphericRequestModel({
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
