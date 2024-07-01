class DistributionEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  DistributionEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory DistributionEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DistributionEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
