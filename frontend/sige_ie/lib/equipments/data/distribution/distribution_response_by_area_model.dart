class DistributionEquipmentResponseByAreaModel {
  int id;
  int area;
  String equipmentCategory;
  int system;
  int quantity;
  String? observation;

  DistributionEquipmentResponseByAreaModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
    required this.quantity,
    required this.observation,
  });

  factory DistributionEquipmentResponseByAreaModel.fromJson(
      Map<String, dynamic> json) {
    return DistributionEquipmentResponseByAreaModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
      quantity: json['quantity'],
      observation: json['observation'],
    );
  }
}
