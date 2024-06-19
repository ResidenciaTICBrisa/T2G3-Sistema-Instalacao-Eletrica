class DistributionEquipmentResponseModel {
  int id;
  String area;
  int system;

  DistributionEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.system,
  });

  factory DistributionEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DistributionEquipmentResponseModel(
      id: json['id'],
      area: json['name'],
      system: json['system'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area,
      'system': system,
    };
  }
}
