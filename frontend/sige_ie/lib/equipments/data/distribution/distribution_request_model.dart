class DistributionRequestModel {
  int? area;
  int? system;

  DistributionRequestModel({
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
