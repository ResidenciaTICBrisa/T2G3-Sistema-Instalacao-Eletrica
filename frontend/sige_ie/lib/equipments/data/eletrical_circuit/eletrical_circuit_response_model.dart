class EletricalCircuitEquipmentResponseModel {
  int id;
  int area;
  String equipmentCategory;
  int system;

  EletricalCircuitEquipmentResponseModel({
    required this.id,
    required this.area,
    required this.equipmentCategory,
    required this.system,
  });

  factory EletricalCircuitEquipmentResponseModel.fromJson(
      Map<String, dynamic> json) {
    return EletricalCircuitEquipmentResponseModel(
      id: json['id'],
      area: json['area'],
      equipmentCategory: json['equipment_category'],
      system: json['system'],
    );
  }
}
