class RefrigerationsRequestModel {
  int? area;
  int? system;

  RefrigerationsRequestModel({
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
