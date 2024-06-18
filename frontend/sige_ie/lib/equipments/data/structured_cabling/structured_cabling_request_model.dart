class StructuredCablingRequestModel {
  int? area;
  int? system;

  StructuredCablingRequestModel({
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
